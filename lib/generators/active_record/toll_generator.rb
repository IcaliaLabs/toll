require 'rails/generators/active_record'
require 'generators/toll/orm_helpers'

module ActiveRecord
  module Generators
    class TollGenerator < ActiveRecord::Generators::Base
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

      include Toll::Generators::OrmHelpers

      source_root File.expand_path("../templates", __FILE__)

      def copy_toll_migration
        if (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?(table_name))
          migration_template "existing_migration.rb", "db/migrate/add_toll_to_#{table_name}.rb"
        else
          migration_template "migration.rb", "db/migrate/toll_create_#{table_name}.rb"
        end
      end

      def generate_model
        invoke "active_record:model", [name], :migration => false unless model_exists? && behavior == :invoke
      end

      def inject_toll_content
        content = %q{  toll}

        class_path = if namespaced?
                       class_name.to_s.split("::")
                     else
                       [class_name]
                     end

        indent_depth = class_path.size - 1
        content = content.split("\n").map { |line| "  " * indent_depth + line } .join("\n") << "\n"
        inject_into_class(model_path, class_path.last, content) if model_exists?
      end

      def migration_data
      %Q{
    ## Toll model fields
    t.string :authentication_token}
      end
    end
  end
end
