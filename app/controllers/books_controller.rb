class BooksController < ApplicationController

  get '/books' do
    if logged_in?
      @user = current_user
      @books = Book.all
      erb :'/books/books'
    else
      redirect to '/login'
    end
  end

  get '/books/new' do
    erb :'/books/create_book'
  end

  post '/books' do

  end

  get '/books/:slug/edit' do

  end

  patch '/books/:slug' do

  end

  delete '/books/:slug/delete' do

  end


end
