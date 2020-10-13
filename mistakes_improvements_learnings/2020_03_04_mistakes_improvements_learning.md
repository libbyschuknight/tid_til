# March / April 2020 Mistakes, Improvements, Learning and Stuff

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
>Local and test are separate — redis is not. Anything set in redis is kept between test runs and may be set during while you're >developing on your local

## Useful tips tricks from newsletters

<https://github.blog/2020-04-09-github-protips-tips-tricks-hacks-and-secrets-from-lee-reilly/>

<https://github.com/benbalter/github-mention-highlighter>

<https://github.com/ovity/octotree>

<https://blog.testdouble.com/posts/2020-04-07-favorite-things/>

## [Action Controller Parameters](https://api.rubyonrails.org/classes/ActionController/Parameters.html)

- [permit(*filters)](https://api.rubyonrails.org/classes/ActionController/Parameters.html#method-i-permit)

Was having an issue where this:

```ruby
params.require(:community_post).permit(:content, :announcement,  updated_media_items: [])
```

was returning `updated_media_items` as nothing!

With some help from colleague, we realised we needed to do this:

```ruby
params.require(:community_post).
  permit(:content, :announcement, updated_media_items: [:key, :name, :size, :type, :media_type])
```

## When debugging and using `rails s` and not `foreman`

FYI was having this issue locally

>NOTE: locally I seem to sometimes be able to create a network message and it shows up in the centre community and sometimes not. Let's double check this once it is on staging.

And I have just realised that because I like to use `binding.pry` to debug stuff and you can't use that when using `foreman` so I go back to the `rails s` why of running the server and I also run the `webpack` in another tab. I have just reaslised that there is a job that copies the network message to a com post for centres, so I wasn't seeing it cos the jobs weren't running!! OMG! So much going on! Will add this `bundle exec sidekiq` to my setup for when I want to debug! 😱

## Rails normal and API controllers

Hello people. Here is a fun problem. Getting this error when running a spec:

```bash
 1) PostsController authorization create Post is a community post sets the status to published
     Failure/Error:
       json[:html]               = render_to_string(
                                     "shared/posts/_post",
                                     layout: false,
                                     locals: { post: @post, single_post: params[:single_post] }
                                   )
     ActionView::MissingTemplate:
       Missing template shared/posts/_post with {:locale=>[:en], :formats=>[:json], :variants=>[], :handlers=>[:raw, :erb, :html, :builder, :ruby, :coffee, :haml]}. Searched in:
         * "/Users/libby/parkstory/storyjar/education/app/views"
         * "/Users/libby/.gem/ruby/2.6.3/gems/switch_user-1.4.0/app/views"
         * "/Users/libby/.gem/ruby/2.6.3/bundler/gems/pghero-96bef48d6776/app/views"
         * "/Users/libby/.gem/ruby/2.6.3/gems/rails_admin-1.3.0/app/views"
         * "/Users/libby/.gem/ruby/2.6.3/gems/kaminari-core-1.1.1/app/views"
         * "/Users/libby/.gem/ruby/2.6.3/gems/doorkeeper-4.4.1/app/views"
         * "/Users/libby/.gem/ruby/2.6.3/gems/devise-4.7.1/app/views"
```

> Have updated the code in the controller to use a CommunityPost::Create use case. Locally works all good. No errors.
> But with needing to update the test I needed to add in the use of as: :json as we need to pass in a boolean and not have it be converted to > a string (ideally).
> And this some how mucks with the spec and makes it think there is no shared/posts/_post, which there is.


Fix for this was to created a method like this:

```ruby
  def parse_announcement(announcement)
    # NOTE: this has been added to make the PostsController#create specs pass
    # as in the specs the params values are stringified.
    # We wanted to keep the validation of the "announcement" value in the CommunityPost::Create
    # use case.
    # This can be removed once the creation of CommunityPosts in this controller has been removed.
    if announcement == "true"
      true
    elsif announcement == "false"
      false
    else
      announcement
    end
  end
```

Not ideal but the code will be updated soon anyway and this will be removed.

And something to remember:

>API requests use JSON by default, regular web controllers will stringify all param values
