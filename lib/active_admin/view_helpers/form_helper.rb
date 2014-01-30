module ActiveAdmin
  module ViewHelpers
    module FormHelper

      def active_admin_form_for(resource, options = {}, &block)
        options = Marshal.load( Marshal.dump(options) )
        options[:builder] ||= ActiveAdmin::FormBuilder

        resource = undecorate_resource(resource) unless options[:decorate]

        semantic_form_for resource, options, &block
      end

      def hidden_field_tags_for(params, options={})
        fields_for_params(params, options).map do |kv|
          k, v = kv.first
          hidden_field_tag k, v, :id => sanitize_to_id("hidden_active_admin_#{k}")
        end.join("\n").html_safe
      end

      private

      def undecorate_resource(resource)
        ActiveAdmin::ResourceController::Decorators.undecorate_resource(resource)
      end
    end
  end
end
