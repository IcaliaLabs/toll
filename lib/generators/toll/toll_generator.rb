module Toll
  module Generators
    class TollGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers

      namespace "toll"
      desc "Creates a model with the given name with toll" <<
           "includes migration files"

     hook_for :orm
    end
  end
end
