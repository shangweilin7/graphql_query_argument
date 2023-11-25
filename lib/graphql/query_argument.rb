module GraphQL
  module QueryArgument
    def self.included(base)
      base.extend ClassMethods
      base.instance_eval do
        @config = {
          query_arguments: {}
        }
      end
    end

    def initialize(object:, context:, field:)
      @scope = context[:current_object].send(field.name.underscore)
      @query_arguments = self.class.config[:query_arguments]
      super object: object, context: context, field: field
    end

    def resolve(**args)
      args.inject(@scope) do |scope, (name, value)|
        return scope unless @query_arguments[name]

        instance_exec scope, value, &@query_arguments[name]
      end
    end

    module ClassMethods
      attr_reader :config

      def inherited(base)
        base.instance_variable_set '@config', @config
        super(base)
      end

      def query_argument(name, options = {}, &block)
        argument(name, options)
        config[:query_arguments][name] = block
      end
    end
  end
end
