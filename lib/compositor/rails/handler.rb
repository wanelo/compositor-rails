module Compositor
  module Rails
    class Handler
      cattr_accessor :default_format
      self.default_format = Mime::JSON

      def self.default_partial_options
        { format: self.default_format }
      end

      def self.call(template)
        # this juggling is required to keep line numbers right in the error
        %{Compositor::Rails::DSL.create(self) do #{template.source}
          end.to_json}
      end
    end
  end
end

ActionView::Template.register_template_handler :compositor, Compositor::Rails::Handler
