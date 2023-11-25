require 'graphql'
require 'graphql/query_argument'

class ProductType < GraphQL::Schema::Object
  field :id, ID
  field :name, String

  def name
    object.name
  end
end

class ProductsResolver < GraphQL::Schema::Resolver
  include GraphQL::QueryArgument

  type [ProductType], null: true

  query_argument :names, type: [String], required: false do |scope, value|
    scope.select { |product| value.include?(product.name) }
  end
end
