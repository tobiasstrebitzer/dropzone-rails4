Dropzone::Engine.routes.draw do
  match '/profile/:profile_id/:entity_id' => 'profiles#info', :constraints => { :profile_id => /[^\/]*/, :entity_id => /[^\/]*/ }, :via => :get
  match '/profile/:profile_id/:entity_id' => 'profiles#upload_image', :constraints => { :profile_id => /[^\/]*/, :entity_id => /[^\/]*/ }, :via => :post
  match '/profile/:profile_id/:entity_id' => 'profiles#delete_image', :constraints => { :profile_id => /[^\/]*/, :entity_id => /[^\/]*/ }, :via => :delete
end
