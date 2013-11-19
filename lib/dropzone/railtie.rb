require 'rails'
module Dropzone
  class Railtie < Rails::Railtie
    
    initializer "dropzone_railtie.configure_rails_initialization" do
      Dropzone.install!
    end
    
    initializer 'dropzone.install' do
      if Rails.configuration.cache_classes
        Dropzone.install!
      else
        ActionDispatch::Reloader.to_prepare do
          Dropzone.install!
        end
      end
    end
    
  end
end
