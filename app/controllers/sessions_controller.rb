class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    puts 'email'
    puts params[:email]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      @error = 'Wrong emal adress or password!'
      render '/sessions/new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
