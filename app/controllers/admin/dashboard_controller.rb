class Admin::DashboardController < ApplicationController
  before_filter :http_authenticate 
  def show
  end
end
