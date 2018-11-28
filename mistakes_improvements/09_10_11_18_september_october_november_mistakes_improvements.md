# September / October / November Mistakes, Improvements, Stuff

## Translation (yaml) files in Rails

Working at adding a new thing to an Rails app that uses translation files to do lots of stuff.

Copied a `en.yml` file that already existed and needed to update the name of it and some other things in it.

Fired up the server and got this error:

```
I18n::InvalidLocaleData
can not load translations from /Users/libby/flux/powershop/nz/brands/meridian/en.yml: #<Psych::SyntaxError: (/Users/libby/flux/powershop/nz/brands/meridian/en.yml): did not find expected key while parsing a block mapping at line 2 column 3>
```

Thought it might have been other things to do with stuff I was changing. Asked a friend who suggested `check your yml for missing "`.

So I did and this and while making changes to it, I accidently put an extra `z` somewhere:

```yaml
en-NZ-realsurf:
  company_name: Real Surf

  contact_hours: "8am to 8pm, Monday to Friday"
  contact_hours_business: "9am to 5pm, Monday to Friday"z
```
Removed it and yay it works!! Such a small thing! A reminder to be careful when changing things and to check and re-check!


## Translations / Locales (yaml files)
### [4.5 Translations for Active Record Models](https://guides.rubyonrails.org/i18n.html#translations-for-active-record-models)

>For example when you add the following translations:
```
en:
  activerecord:
    models:
      user: Dude
    attributes:
      user:
        login: "Handle"
      # will translate User attribute "login" as "Handle"
```
>Then User.model_name.human will return "Dude" and User.human_attribute_name("login") will return "Handle".

### Using a list in translation files to add list text to view

This was a case of wanting to do a few things. We had text to add and we had cases where there would be a different company name depending on the country and also a link that to a pdf that would show a different pdf depending on the country.

You can use an array in a yaml file and then iterate over it in the view. And within the method used to use the translation information in the view you can pass specific argruments and use other translations. Not that easy to explain but the code below should show what I mean.

```yaml
# en.yml

confirmation_one:
  confirmation: "I confirm that:"
  list_content:
    - I am allowed to do x, y and z
    - by providing  %{company_name} with some stuff and I have look at %{link_to_agreement};
    - another parpagraph of information to year

# after getting feedback from a colleague, I learnt that the above way of making a list is the more "yaml" way, rather then explicitly using [] as I have below
  list_content: [
    "I am allowed to do x, y and z",
    "by providing  %{company_name} with some stuff and I have look at %{link_to_agreement};",
    "another parpagraph of information to year"
  ]
```

```html
<!-- a view file  -->
<ul class="disc indent-30">
  <% t("confirmation_one.list_content",
        company_name: t("company_name"),
        link_to_agreement:
          (
            link_to "The Agreement",
            country_pdf_path("the_agreement.pdf"),
            target: "_blank",
            rel: "noopener noreferrer"
          )
      ).each do |line| %>
    <li><%= line.html_safe %></li>
  <% end %>
</ul>
```




## Making requests to APIs

Using `Net::HTTP`, get request to Hubspot API.

https://developers.hubspot.com/docs/methods/lists/get_list_contacts_recent
`GET /contacts/v1/lists/:list_id/contacts/recent`

https://api.hubapi.com/contacts/v1/lists/120824/contacts/recent?hapikey=demo
Returns stuff as of Sept 2018

For this, wanted to be able to pass in the `list_id` and have optional params for offsets to do paginigation and be able to change the count if needed.

```ruby
# requires rails
module Hubspot
  class FetchRecentContactsForList
    BASE_URL = "https://api.hubapi.com"

    def initialize(list_id:)
      @list_id = list_id
    end

    def fetch_contacts(vid_offset: nil, time_offset: nil, count: 5)
      params = {
        hapikey: api_key,
        vidOffset: vid_offset,
        timeOffset: time_offset,
        count: count
      }
      uri = URI.parse(build_url(params))
      request = Net::HTTP.new(uri.host, uri.port)
      request.use_ssl = true if uri.scheme == 'https'
      response = request.get(uri)
      JSON.parse(response.body)
    end

    private

    def build_url(params)
      "#{BASE_URL}/contacts/v1/lists/#{@list_id}/contacts/recent?#{params.compact.to_query}"
    end

    def api_key
      "demo"
    end
  end
end

hub = Hubspot::FetchRecentContactsForList.new(list_id: 120824)
hub.fetch_contacts
```

Response:
```json
{
       "contacts" => [
        [0] {
                      "addedAt" => 1537302433623,
                          "vid" => 9419024,
                "canonical-vid" => 9419024,
                  "merged-vids" => [],
                    "portal-id" => 62515,
                   "is-contact" => true,
                "profile-token" => "AO_T-mPnLRnWxlb3nMMrPXeIfEXz5WpO0k9M7zBlCkD6s0cZyS4wqGeN0E2aiCaEZZ2FRfQJyIEdqHOKIT_hRyLfkK4wRKX5m-xGpQh521x96NgKYrHVH0DZqLU3V7-Y9vpC-6prU0np",
                  "profile-url" => "https://app.hubspot.com/contacts/62515/lists/public/contact/_AO_T-mPnLRnWxlb3nMMrPXeIfEXz5WpO0k9M7zBlCkD6s0cZyS4wqGeN0E2aiCaEZZ2FRfQJyIEdqHOKIT_hRyLfkK4wRKX5m-xGpQh521x96NgKYrHVH0DZqLU3V7-Y9vpC-6prU0np/",
                   "properties" => {
                       "firstname" => {
                    "value" => "Emily"
                },
                "lastmodifieddate" => {
                    "value" => "1537302437940"
                },
                        "lastname" => {
                    "value" => "Schwickerath"
                }
            },
             "form-submissions" => [],
            "identity-profiles" => [
                [0] {
                                          "vid" => 9419024,
                           "saved-at-timestamp" => 1537302425752,
                    "deleted-changed-timestamp" => 0,
                                   "identities" => [
                        [0] {
                                  "type" => "EMAIL",
                                 "value" => "schwickerathe@skokie69.net",
                             "timestamp" => 1537302425741,
                            "is-primary" => true
                        },
                        [1] {
                                 "type" => "LEAD_GUID",
                                "value" => "713020ee-9993-4b93-9865-b5916fb3a85f",
                            "timestamp" => 1537302425748
                        }
                    ]
                }
            ],
                 "merge-audits" => []
        },
        ...
```


## Specs
Think I have come across this before, created a new spec, ran it and got an error like this:

```bash
ActiveRecord::NotNullViolation:
       Mysql2::Error: Field 'credit' doesn't have a default value: INSERT INTO `promotion_grants` (`id`, `created_at`, `updated_at`, `discount_voucher_category_id`, `promotion_id`, `delay_until`, `delay_days`) VALUES (644667019, '2018-09-24 12:09:24.770222', '2018-09-24 12:09:24.770222', 284678023, 644667019, NULL, NULL), (16771602, '2018-09-24 12:09:24.770222',
```
And was like WTF?!! as my spec wasn't doing anything with the db (service making a request to an external API) and the remembdered about making sure the test database was all nice and clean.

Ran `rails db:test:prepare`, but that seems not to have worked. I think that works nicely on postgres databases but not so nicely with MariaDB database, or at least how it is set up at work.

Have just found out more about `rails/rake db:test:prepare` -
https://guides.rubyonrails.org/v5.0/testing.html#maintaining-the-test-database-schema

and this part
>Running the migrations against the development database (bin/rails db:migrate) will bring the schema up to date

So should have run `rails db:migrate db:test:prepare`. Which I actually usually do when having just synced the db (work thing but didn't this time.

Also found a rake task in our codebase that drops, creates, loads structure and runs migrations. And that has worked! Yay!


## VScode

Adding user snippets.
I use rspec and there is a lot of times you need to write `do newline end`:
```ruby
something do

end
```
There didn't seem to be a shortcut for this so I added one to my user snippets.

Go to preferences and user snippets and and existing or new snippets file (is a json file). I had existing one and copied on of the ones already there and changed it to this:

```json
"Insert do end": {
  "prefix": "de",
  "body": [
    "do\n\nend"
  ],
  "description": "Insert do end (mainly for specs) at cursor location"
}
```
And when I type `de` enter, it does this:
```ruby
do

end
```

So if wanted to do a let block with a do end, could do:
```ruby
let(:this) de
# and would give me

let(:this) do

end
```

With an extenstion (https://marketplace.visualstudio.com/items?itemName=karunamurti.rspec-snippets) I already have I can write `let` and get `let(:object) {  }` but often I need the do/end.

Possibly a hack day projects would be to add some stuff to that extension.


## Net::HTTP::Post

Just spent ages trying to get a post request happening with Net::HTTP.

Most things I found where showing to do with with `set_form_data`, like this:

```ruby
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true if uri.scheme == "https"
request = Net::HTTP::Post.new(uri.request_uri)
raw_body = [
    {
      "vid": "402",
      "properties": [
        {
          "property": "firstname",
          "value": "Lizzy"
        },
        {
          "property": "lastname",
          "value": "Knight"
        },
        {
        "property": "lifecyclestage",
        "value": "customer"
        }
      ]
    }
  ]

request.set_form_data(raw_body)
request["Content-Type"] = "application/json"

response = http.request(post_request)
```

but it kept coming up with a bad request error:
```
"{\"status\":\"error\",\"message\":\"Invalid input JSON on line 1, column 2: Unexpected character ('%' (code 37)): expected a valid value (number, String, array, object, 'true', 'false' or 'null')\",\"correlationId\":\"858c584c-5157-44fa-bb6f-94b7a7855159\",\"requestId\":\"eea949ee93f3eb71e990d53affdaf96c\"}"
```
I think I was doing something wrong with what I was passing into the `set_form_data` but couldn't figure out what it was.
Things I have been looking all seem to do a post using `post_form` - https://github.com/augustl/net-http-cheat-sheet/blob/master/post_form.rb.

But then found this - https://coderwall.com/p/c-mu-a/http-posts-in-ruby and did this:

```ruby
uri = URI.parse(build_url(params))

header = { 'Content-Type': 'application/json' }

body = [
  {
    "vid": "402",
    "properties": [
      {
        "property": "firstname",
        "value": "Lizzy"
      },
      {
        "property": "lastname",
        "value": "Knight"
      },
      {
      "property": "lifecyclestage",
      "value": "customer"
      }
    ]
  }
]

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true if uri.scheme == "https"
request = Net::HTTP::Post.new(uri.request_uri, header)
request.body = body.to_json
response = http.request(request)
```

And it worked! Yay!
Now to figure out why the other way didn't work. Maybe something to do with what passing into the form.
In the example it has:
`request.set_form_data({"q" => "My query", "per_page" => "50"})`
and for the endpoint I am hitting it needs to be in an array, so wondering if I am passing things in incorrectly.


## Another raise_error in RSpec!!!
Has this:

```ruby
it "returns an exception" do
  response = request.call
  expect { response }.to raise_error(Net::HTTPServerException)
end
```

But needed to do this!! Always forget that the subject (?) has to be within a block, with the expect block.

```ruby
it "raises the error" do
  expect { request.call }.to raise_error(Net::HTTPServerException)
end
```


## Stubbing external API calls

Spec

```ruby
...
let(:body_json) do
  "[{\"vid\":402,\"properties\":[{\"property\":\"apples\",\"value\":\"bananas\"},{\"property\":\"rabbits\",\"value\":\"bunnies\"}]}]"
end

context "when the update is successful" do
  before do
    stub_request(:post, "/hubspot_endpoint")
      .with(:body => body_json, :headers => { "Content-Type" => "application/json" })
      .to_return(:status => 202)
  end

  it "returns true" do
    response = request.call

    expect(response).to be_true
  end
end
```

Was working on having another `it` block that tested if the data sent to a service was then changed when it made a call to the Hubspot API.
I didn't realise that within this stub when are testing that already.

So if the `body_json` doesn't much what is passed to the `post` request, the stub will fail. E.g if I change the `(body: body_json,` to be `(body: "")`, the spec fails with this:

```bash
1) Hubspot::BulkUpdateLeadProperties#call when the update is successful returns true
     Failure/Error: response = request.call

     WebMock::NetConnectNotAllowedError:
       Real HTTP connections are disabled. Unregistered request: POST /hubspot_endpoint with body '[{"vid":402,"properties":[{"property":"apples","value":"bananas"},{"property":"rabbits","value":"bunnies"}]}]' with headers {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}

       You can stub this request with the following snippet:

       stub_request(:post, "/hubspot_endpoint").
         with(:body => "[{\"vid\":402,\"properties\":[{\"property\":\"apples\",\"value\":\"bananas\"},{\"property\":\"rabbits\",\"value\":\"bunnies\"}]}]",
              :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
         to_return(:status => 200, :body => "", :headers => {})

       registered request stubs:

       stub_request(:post, "/hubspot_endpoint").
         with(:body => "",
              :headers => {'Content-Type'=>'application/json'})
```

