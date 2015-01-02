# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  before_filter :leftbar

  def leftbar
    @current_page = "connexion"
  end

  def new
  end

  def create
    user = User.find_by(login: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.is_active
        flash[:success] = 'Welcome'
        sign_in user
        redirect_to root_path
        #redirect_to :action => "main", :controller => "home"
      else
        flash[:danger] = "Your account is not activated, please contact the webmaster."
        render 'new'
      end
    else
      flash[:danger] = 'bad email or password' # Not quite right!
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end

end
