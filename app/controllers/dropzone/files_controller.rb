class Dropzone::FilesController < Dropzone::ApplicationController
  before_filter :signed_in_user

  def index
    
  end

  def create
  
    # Get profile
    abort Dropzone.configuration.inspect
  
    app_profile_image = AppProfileImage.new(params.require(:app_profile_image).permit(:image, :app_profile_id, :key))
    app_profile = app_profile_image.app_profile
  
    respond_to do |format|
      if app_profile_image.save
        format.json { render json: {status: 'success', percentage_complete: app_profile.percentage_complete}, status: :created, location: app_profile_image }
      else
        format.json { render json: app_profile_image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  
    abort "destroy"
  
    if is_owner
      @app_profile_image = AppProfileImage.find(params[:id])
      @app_profile_image.destroy

      respond_to do |format|
        format.json { head :no_content }
      end
    else
      flash[:danger] = 'Whoops you can only delete your own profile images.'
      format.json { render json: {status: 'error', redirect: app_profiles_path }, status: :unprocessable_entity }
    end
  end

  private

    def is_owner
      @app_profile_image = AppProfileImage.find(params[:id])
      @user = User.find(@app_profile_image.app_profile.user_id)
      current_user?(@user)
    end
end
