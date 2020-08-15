class SessionsController < Devise::SessionsController

  def new
    super
  end

  def create
    self.resource = User.find_by(email: params[:user][:email])

    respond_to do |format|
      if resource and resource.valid_password?(params[:user][:password])
        sign_in(resource_name, resource)
        set_flash_message(:notice, :signed_in)
        format.html { respond_with resource, location: after_sign_in_path_for(resource)}
        format.js { render json: resource }
      else
        message = "Invalid email or password."
        if request.format.html?
          set_flash_message(:alert, :invalid)
        end
        format.html { redirect_to new_user_session_path, alert: message}
        format.js { render json: {message: message, success: '0'}, status: 200 }
      end
    end
  end
end
