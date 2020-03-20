# March 2020 Mistakes, Improvements, Learning and Stuff

## ActiveRecord::RecordNotFound being rescued

A change that was made at work, I reviewed the change so when I came across this problem, should I have figured it out? Maybe, although the first test was passing when I first was working on my change. Then the new code was added via merging in master. Maybe I need to pay more attention to changes that I am merging into the code I am working on, which would hopefully mean I might pick things like this up.

When a `ActiveRecord::RecordNotFound` occurs it is being rescued in the `Api::V3::BaseController` so it will more useful errors for development and testing environments.T

The changes:

```ruby
...

rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

def record_not_found(exception)
  message = safe_env? ? exception.message.to_s : "Not found"

  render json: {
    meta: {
      message: [message],
      status: "error",
      success: false
    }
  }, status: :not_found
end
```

This could cause problems when testing if you are trying to test if an `ActiveRecord::RecordNotFound` has been raised.

For example, with this expect:

```ruby
...
it "raises a 404" do
  $feature[:search_this].disable

  expect { get :index, params: { q: "spectacular" } }.to raise_error(ActiveRecord::RecordNotFound)
end
```

It will fail:

```bash
1) Api::V3::CommunityPosts::SearchController#index without feature enabled raises a 404
     Failure/Error: expect { get :index, params: { q: "spectacular" } }.to raise_error(ActiveRecord::RecordNotFound)
       expected ActiveRecord::RecordNotFound but nothing was raised
```

What will work now is something like this:

```ruby
it "raises a not found error" do
  $feature[:search_this].disable
  get :index, params: { q: "spectacular" }, format: :json

  expect(response).to have_http_status(:not_found)
end
```

## Future proofing against N+1 queries

```ruby
# initial query
Post.joins(:centre).where(groups: {id: current_user.visible_groups})

# in the server output get this sql count
"sql":25,

# addition of includes

Post.includes(:media_items, user: :profile_image).joins(:centre).where(groups: {id: current_user.visible_groups})

# in the server output get this sql count
"sql":21,
```

Doesn't seem like a lot, but this is only in development so a tiny set of data. Probably make a big difference with a lot of data.

## Flipper feature flags and redis

[Redis](https://redis.io/)

[flipper](https://flippercloud.io/)

<https://github.com/jnunemaker/flipper>

Had issue with tests failing that had a feature flag and the test env being affected by the dev env locally. I got confused about the dbs and flipper.

Flipper uses redis which affects both the dev and test envs. The dbs do not affect each other

Slack convo:

>Would love someone to sit down with me to help me understand the interaction between the local dev db and the local test db.
>I don't recall this being an issue in other places I have worked as I thought your local development db and the local test db were separate.
>Or it is the fact that I haven't worked with anything like flipper before and the feature flag thing is confusing me? But I wouldn't expect a flag that is enabled in my dev env to affect my test env. or maybe I am overthinking things.
>
>Colleague 1
>It's more complex with flipper because the state for it is stored in redis, which isn't unique across dev/test - It probably >wouldn't be hard to fix that though, you'd just add a namespace for the dev environment
>
>Colleague 1
>Local and test are separate—redis is not. Anything set in redis is kept between test runs and may be set during while you're >developing on your local
