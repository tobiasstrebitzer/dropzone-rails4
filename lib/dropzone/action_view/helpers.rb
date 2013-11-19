module Dropzone
  module ActionView
    module Helpers
  
      def dropzone(entity, profile)
        url = Dropzone::Engine.routes.url_for :controller => 'dropzone/profiles', :action => 'info', :only_path => true, :format => :json, :profile_id => profile.to_s, :entity_id => entity.id
        raw("<div class='dropzone-ui' data-url='#{url}'></div>")
      end
    end
  end
end
