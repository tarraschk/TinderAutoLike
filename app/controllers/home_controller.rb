# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  before_action :require_login
  before_filter :leftbar

  def leftbar

  end

  respond_to :json
  def main
  end
end
