require 'rails'
module Dropzone
  class Railtie < Rails::Railtie
    
    initializer "dropzone_railtie.configure_rails_initialization" do
      Dropzone.install!
    end
  end
end
