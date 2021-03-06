class UsersController < ApplicationController

require 'pry'

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      redirect to '/books'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect to '/signup'
    else
      if !User.find_by(username: params[:username])
        @user = User.create(params)
        session[:user_id] = @user.id
        redirect to '/books'
      end
      redirect to '/signup'
    end
  end

  get '/signin' do
    if !logged_in?
      erb :'users/login'
    else
      redirect to '/books'
    end
  end

  post '/signin' do
    @user = User.find_by(:username => params[:username])
      # binding.pry
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/books'
    else
      redirect to '/signin'
    end
  end

  get '/users/:slug' do
     # binding.pry
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      if @user == current_user
        # erb :'users/show'
        redirect to '/books'
      else
        redirect to '/signin'
      end
    else
      redirect to '/signin'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/signin'
    else
      redirect to '/'
    end
  end

end
