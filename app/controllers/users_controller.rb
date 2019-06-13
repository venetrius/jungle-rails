class UsersController < ApplicationController
  def new
  end

def create
  @user = User.new(user_params)
  render 'new'
end

private

def user_params
end

end
