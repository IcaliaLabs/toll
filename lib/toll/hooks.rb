require 'toll/interface'

ActiveSupport.on_load :active_record do
  include Toll::Interface
end
