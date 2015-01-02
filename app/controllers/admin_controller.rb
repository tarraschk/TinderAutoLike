# -*- encoding : utf-8 -*-
class AdminController < ApplicationController
  before_action :require_login
  before_filter :leftbar

  def leftbar
    @current_page = "admin"
  end

  def index
    if current_user.is_admin
      @users = User.order(is_active: :desc, id: :desc).all
      render 'index'
    else
      redirect_to root_path
    end
  end

end
