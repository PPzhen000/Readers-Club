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

  end

  get '/signin' do

  end

  post '/signin' do

  end

  get '/users/:slug' do

  end

  get '/logout' do

  end

end
