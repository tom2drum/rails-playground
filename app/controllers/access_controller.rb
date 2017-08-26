class AccessController < ApplicationController

  layout 'admin'

  before_action :confirm_logged_in, except: [:login, :attempt_login, :logout]

  def menu
  end

  def login
  end

  def attempt_login
    if params[:username].present? && params[:password].present?
      found_user = AdminUser.where(username: params[:username]).first
      if found_user
        auth_user = found_user.authenticate(params[:password])
      end
    end

    if auth_user
      session[:user_id] = auth_user.id
      flash[:notice] = 'You are now logged in'
      redirect_to(admin_path)
    else
      flash.now[:notice] = 'Invalid username/password'
      render('login')
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = 'You are logged out'
    redirect_to(access_login_path)
  end

end