class BooksController < ApplicationController

  get '/books' do
     binding.pry
    if logged_in?
      erb :'/books/books'
    else
      redirect to '/signin'
    end
  end

  get '/books/new' do
    erb :'/books/create_book'
  end

  post '/books' do
    # binding.pry
    if logged_in?
      if params[:title] == "" || params[:author_name] == ""
        redirect to '/books/new'
      else
        @book = current_user.books.build(title: params[:title], author_name: params[:author_name], category_id: params[:category_id])
        if @book.save
          redirect to '/books'
        else
          redirect to '/books/new'
        end
      end
    else
      redirect to '/signin'
    end
  end

  get '/books/:slug' do
    # binding.pry
    if logged_in?
      @book = Book.find_by_slug(params[:slug])
      if @book && @book.users.first == current_user  #assuming each book only belongs to one user for now
        erb :'books/show_book'
      else
        redirect to '/books'
      end
    else
      redirect to '/signin'
    end
  end

  get '/books/:slug/edit' do
    # binding.pry
    if logged_in?
      @book = Book.find_by_slug(params[:slug])
      if @book && @book.users.first == current_user  #assuming each book only belongs to one user for now
        erb :'books/edit_book'
      else
        redirect to '/books'
      end
    else
      redirect to '/signin'
    end
  end

  patch '/books/:slug' do
    # binding.pry
    if logged_in?
      if params[:title] == "" || params[:author_name] == ""
        redirect to "/books/#{params[:slug]}/edit"
      else
        @book = Book.find_by_slug(params[:slug])
        if @book && @book.users.first == current_user
          @book.update(title: params[:title], author_name: params[:author_name], category_id: params[:category_id])
          redirect to "/books"
        else
          redirect to "/books/#{@book.slug}/edit"
        end
      end
    else
      redirect to '/signin'
    end
  end

  delete '/books/:slug/delete' do
    binding.pry
    if logged_in?
      @book = Book.find_by_slug(params[:slug])
      if @book && @book.users.first == current_user
        @book.delete
      end
      redirect to '/books'
    else
      redirect to '/signin'
    end
  end


end
