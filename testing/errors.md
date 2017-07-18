# Errors in Testing

### Recursive method by mistake
Had an issue in with a test where I was getting an error:

```bash
1) Resources::ChargeSource deleting a charge source is successful
     Failure/Error:
       def self.delete(id:, charge_source_deleter: self)
         path = "#{resource_path}/#{id}"
         charge_source_deleter.delete(path)
       end

     ArgumentError:
       wrong number of arguments (1 for 0)
```

I realised I basically had `charge_source_deleter.delete` calling itself.
So renamed the first 'delete' to `delete_source`.

The code for the class is:

```ruby
module Resources
  class ChargeSource < OpenStruct
    include things...

    ENDPOINT = "endpoint"

    def self.delete_source(id:, charge_source_deleter: self)  # was self.delete
      path = "#{resource_path}/#{id}"
      charge_source_deleter.delete(path)
    end

    def self.resource_path
      ENDPOINT
    end
  end
end
```
