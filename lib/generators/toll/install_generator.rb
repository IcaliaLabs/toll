module Toll
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__) 

      desc "Creates a Toll initializer in your application"

       def copy_initializer
        template "toll.rb", "config/initializers/toll.rb"
       end
    end
  end
end
