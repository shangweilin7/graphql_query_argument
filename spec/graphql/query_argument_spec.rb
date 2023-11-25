require 'spec_helper'

describe GraphQL::QueryArgument do
  class GraphQLSchema < GraphQL::Schema
    class QueryType < GraphQL::Schema::Object
      field :products, resolver: ProductsResolver

      def products
        [OpenStruct.new(name: 'Product A'),
         OpenStruct.new(name: 'Product B'),
         OpenStruct.new(name: 'Product C')]
      end
    end

    query(QueryType)
  end

  context 'query products' do
    it 'returns specify products' do
      query_str = <<-GRAPHQL
      query {
        products(names: ["Product B", "Product C"]) {
          name
        }
      }
      GRAPHQL
      result = GraphQLSchema.execute(query_str)
      expect(result['data']['products']).to eq([
        { 'name' => 'Product B' }, { 'name' => 'Product C'}
      ])
    end
  end
end
