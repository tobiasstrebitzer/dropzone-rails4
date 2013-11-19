module Dropzone
  module ActionView
    module Helpers
  
      def dropzone(entity, profile)
        url = dropzone_engine.url_for :controller => 'dropzone/profiles', :action => 'info', :format => :json, :profile_id => profile.to_s, :entity_id => entity.id
        raw("<div class='dropzone-ui' data-url='#{url}'></div>")
      end
    end
  end
end
