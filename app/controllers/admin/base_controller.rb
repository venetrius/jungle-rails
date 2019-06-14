class Admin::BaseController  < ApplicationController

  before_filter :http_authenticate 

  private 
  def http_authenticate
    authenticate_or_request_with_http_basic do |username, password|
       puts  Rails.configuration.admin[:user_name]
       puts  Rails.configuration.admin[:password]
       if username == Rails.configuration.admin[:user_name] && Rails.configuration.admin[:password]
         puts 'ok'
         return true
       end
   end
  end

end