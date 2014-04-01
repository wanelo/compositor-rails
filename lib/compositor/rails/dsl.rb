require 'compositor'

module Compositor
  module Rails
    class DSL < Compositor::DSL

      def initialize(*args)
        super
        @partial_variable_counter = 0
      end

      def partial!(name_or_options, locals = {})
        case name_or_options
        when ::Hash
          # partial! partial: 'name', locals: { foo: 'bar' }
          options = name_or_options
        else
          # partial! 'name', foo: 'bar'
          options = { partial: name_or_options, locals: locals }
          as = locals.delete(:as)
          options[:as] = as if as.present?
          options[:collection] = locals[:collection] if locals.key?(:collection)
        end

        _handle_partial_options options
      end

      private

      def _handle_partial_options(options)
        options.reverse_merge! locals: {}
        options.reverse_merge! ::Compositor::Rails::Handler.default_partial_options
        _render_partial options
      end

      def _render_partial(options)
        template = _lookup_context.find_template(options[:partial],
                                                 [],
                                                 true,
                                                 [],
                                                 options)

        instance_eval _compile_partial(template, options)
      end

      def _compile_partial(template, options)
        source = ""
        options[:locals].each do |k, v|
          name = "@partial_#{@partial_variable_counter}"
          instance_variable_set name, v
          source << "#{k} = #{name};"
          @partial_variable_counter += 1
        end
        source << template.source
        source
      end

      def _lookup_context
        context.controller.view_renderer.lookup_context
      end
    end
  end
end
