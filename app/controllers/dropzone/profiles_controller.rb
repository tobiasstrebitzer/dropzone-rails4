class Dropzone::ProfilesController < ::ApplicationController
  
  def info
    
    # Load profile
    profile = Dropzone.get_profile(params[:profile_id])
    
    # Load entity
    entity_class = profile["entity_class"].constantize
    entity = entity_class.find(params[:entity_id])
    
    # Load existing images
    image_class = profile["image_class"].constantize
    whereParams = { key: params[:profile_id] }
    whereParams[entity_class.name.underscore] = entity
    images = image_class.where(whereParams).map{|image| {name: image.image_file_name, size: image.image_file_size, src: image.image(:dropzone), id: image.id} }
    
    render json: {profile: {
      allowed_sizes: profile['allowed_sizes'],
      allowed_types: profile['allowed_types'],
      max_files: profile['max_files'],
      width: profile['width'],
    }, images: images, entity_id: entity.id}
    
  end

  def upload_image
    
    # Load profile
    profile = Dropzone.get_profile(params[:profile_id])
    
    # Load entity
    entity_class = profile["entity_class"].constantize
    entity = entity_class.find(params[:entity_id])
    
    # Load image
    if current_user?(entity.user)
    
      # Create image
      image_class = profile["image_class"].constantize
      image = image_class.new({image: params[:image]})
      image.send("#{entity_class.name.underscore}=", entity)
      image.key = params[:profile_id]
    
      # Save image
      if image.save
        resultData = {status: 'success', id: image.id};
        if image.respond_to?(:dropzone_save_response)
          image.dropzone_save_response(resultData)
        end      
        render json: resultData, status: :created
      else
        render json: image.errors, status: :unprocessable_entity
      end
    else
      render json: { success: false }
    end

  end
  
  def delete_image
    
    # Load profile
    profile = Dropzone.get_profile(params[:profile_id])
    
    # Load image
    image = profile["image_class"].constantize.find(params[:id])
    
    if current_user?(image.user)
      image.destroy
      head :no_content
    else
      render json: { success: false }
    end

  end

end
