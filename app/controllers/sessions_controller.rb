class SessionsController < ApplicationController

  def create
    data = request.env['omniauth.auth']
    user = User.find_by_uid(data['uid'])
    user ||= User.create uid: data['uid']
    session[:user_id] = user.id
    session[:user_name] = request.env['omniauth.auth']['info']['name']
    redirect_to products_url, notice: "Welcome #{session[:user_name]}!"
  end

  def destroy
    reset_session
    redirect_to root_url, notice: "Goodbye!"
  end
end
