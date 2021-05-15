class ApplicationController < ActionController::Base
  #ユーザ登録、ログイン認証など）が使われる場合、その前にconfigure_permitted_parametersが実行
  before_action :configure_permitted_parameters, if: :devise_controller?
  #before_action :redirect_root, if: :authenticate_user!
  #before_action :authenticate_user! ,except: [:top ,:about]
  
    #ログイン先の
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end
  
  protected

  def configure_permitted_parameters
    #ユーザ登録（sign_up）の際に、ユーザ名（name）のデータ操作が許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end



end
