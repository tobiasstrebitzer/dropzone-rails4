require 'dropzone/railtie'
require 'dropzone/action_view/helpers'

module Dropzone
  
  class Engine < ::Rails::Engine
    isolate_namespace Dropzone
  end

  class << self
    attr_accessor :configuration
  end
  
  def self.get_profile(profile)
    profile = Dropzone.configuration.profiles[profile.to_s]
    defaults = Dropzone.configuration.profiles["default"]
    profile.reverse_merge!(defaults)
  end
  
  def self.install!
    config = YAML.load_file("#{Rails.root.to_s}/config/dropzone.yml")[Rails.env]
    Dropzone.configure { |c| 
      c.profiles = config["profiles"] || []
    }
    
    ActiveSupport.on_load :action_controller do
      helper Dropzone::ActionView::Helpers
    end

  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class Configuration
     attr_accessor :profiles
  end

  def self.included(base)
    # base.extend ClassMethods
    # base.send :include, InstanceMethods
  end


end
