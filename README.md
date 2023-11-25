# GraphQL::QueryArgument
A simple module for graphql resolver

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'graphql_query_argument'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install graphql_query_argument
```
## Usage
```ruby
require 'graphql/query_argument'

# `Products < Resolvers::Base`:
#
module Resolvers
  class Products < Resolvers::Base
    include GraphQL::QueryArgument

    type [Types::ProductType], null: false

    query_argument :name, type: [String], required: false do |scope, value|
      scope.where(name: value)
    end
    query_argument :categories, type: Types::CategoryQueryInputs, required: false do |scope, value|
      scope.joins(:categories).where(categieies: { **value })
    end
  end
end
```
```ruby
# `CompanyType`:
class CompanyType < Types::BaseObject
  field :products, null: false, resolver: Resolvers::Products

  def products
    object.products
  end
end
```
```ruby
# `CategoryQueryInputs`:
module Types
  class CategoryQueryInputs < Types::BaseInputObject
    argument :name, [String], required: false
  end
end
```
