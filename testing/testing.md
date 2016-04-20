# Testing - general

#### Rails Conf 2013 The Magic Tricks of Testing by Sandi Metz
A must watch and re-watch - [Rails Conf 2013 The Magic Tricks of Testing by Sandi Metz]https://www.youtube.com/watch?v=URSWYvyc42M

#### Using OpenStructs
When using OpenStruct in tests, need to look at the things that are being passed into the object you are wanting to recreate.

e.g.
module representer for api
```ruby
    module Role
      include ::Representers::Base

      property :id

      property :kind

      property :role

      property :identifiers, class: OpenStruct do
        property :something_id
      end

      property :party, embedded: true, extend: Representers::Party, class: ::Party

      link :self do
        "/party_roles/#{id}"
      end

      link :party do
        "/parties/#{party_id}"
      end
    end
  end
end
```

creating objects to use in spec
```ruby
let(:st_id) do
  OpenStruct.new(something_id: "FLCK")
end

let(:party) do
  OpenStruct.new(
    id: "e4e5300b-600c-4335-a139-2050edbed254",
    kind: "party",
    name: "The Part Party"
  )
end

let(:object) do
  OpenStruct.new(
    id: "999ec5a8-4037-45ba-bbf0-1dc9db8f9fcc",
    kind: "party_role",
    role: "entertainer",
    identifiers: st_id,
    party: party,
    party_id: party.id
  )
end
```
My point being, make sure that what the properties are in the OpenStruct object, are the same as what is in the Role. For example, `party_id` needs to be `party.id`.

#### Params
If you change the columns on your table, remember to change the 'strong params' that are allowed to pass through.

#### TIME
##### Stub out in RSpec
```ruby
allow(Time).to receive(:now).and_return(Time.parse('2016-03-02'))
```
Needed to use `Time.utc(2016, 8, 1, 14, 34, 56)`, otherwise was failing on Travis due to different timezones.
