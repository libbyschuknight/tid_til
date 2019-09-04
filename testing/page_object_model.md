# Page Object Model - POM

## In Ruby

[SitePrism](https://github.com/natritmeyer/site_prism)

>A Page Object Model DSL for Capybara
>
>SitePrism gives you a simple, clean and semantic DSL for describing your site using the Page Object Model pattern, for use with Capybara in automated acceptance testing.

## Old cuke steps to new cuke steps using POM

Note: you can't combine Selenium and POM interactivity steps together. You can combine setup that doesn't touch a browser (e.g. modifying the database etc), but nothing that involves clicking, page content, etc.


## require relative (uninitialized constant error)

Been adding in POMs for a resource that has index, new, show, edit pages, and form partial.

Looking at how it was done in other places, people had created a `form_section.rb` POM section, that was then used within the `new_page.rb` POM and the `edit_page.rb`.

As I had already added the a `form` section with in the `new_page` POM, I first added the `form_section` within there.

```ruby
module Admin::PremiumProviders
  class NewPage < SitePrism::Page
    set_url "/admin/premium_providers/new"

    section :form, FormSection, :xpath, "//div[@class='page-content']//form"
  end
end
```

This worked fine.

I then created my `EditPage` POM, using the `FormSection` section POM.

```ruby
module Admin::PremiumProviders
  class EditPage < SitePrism::Page
    set_url "/admin/premium_providers/{premium_provider_id}/edit"

    section :form, FormSection, :xpath, "//div[@class='page-content']//form"
  end
end
```

Everything was exactaly the same as the `NewPage` and I had added the page properly to the `website.rb` file.

But I kept getting this error:

```bash
uninitialized constant Admin::PremiumProviders::EditPage::FormSection (NameError)
/Users/libby/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.3.2/lib/bootsnap/load_path_cache/core_ext/active_support.rb:74:in `block in load_missing_constant'
/Users/libby/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.3.2/lib/bootsnap/load_path_cache/core_ext/active_support.rb:8:in `without_bootsnap_cache'
/Users/libby/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.3.2/lib/bootsnap/load_path_cache/core_ext/active_support.rb:74:in `rescue in load_missing_constant'
/Users/libby/.rbenv/versions/2.6.3/lib/ruby/gems/2.6.0/gems/bootsnap-1.3.2/lib/bootsnap/load_path_cache/core_ext/active_support.rb:56:in `load_missing_constant'
/Users/libby/flux/powershop/core/features/page_object_models/admin/premium_providers/edit_page.rb:8:in `<class:EditPage>'
/Users/libby/flux/powershop/core/features/page_object_models/admin/premium_providers/edit_page.rb:5:in `<module:PremiumProviders>'
/Users/libby/flux/powershop/core/features/page_object_models/admin/premium_providers/edit_page.rb:4:in `<main>'
```

I was scratching my head. Got my colleague to have a look and he pointed out that due to the `edit_page.rb` coming before the `form_section.rb` in the folder:

```bash
├── premium_providers
│   ├── edit_page.rb
│   ├── form_section.rb
│   ├── index_page.rb
│   ├── new_page.rb
│   └── show_page.rb
```

that I would probably need to add this to the `edit_page.rb`:

```ruby
require_relative "form_section"
```

So I did and it worked and then I looked at the other `edit_page.rb` in the other folders which are using the same set up and they also have this. I had not thought to look at the other edit pages!
