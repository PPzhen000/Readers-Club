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
    if logged_in?
      if params[:title] == "" || params[:author_name] == ""
        redirect to '/books/new'
      else
        @book = current_user.books.build(title: params[:title], author_name: params[:author_name])
        @book.save
        redirect to '/books'
      end
    else
      redirect to '/login'
    end
  end

  get '/books/:slug/edit' do
    if logged_in?
      @book = Book.find_by_id(params[:id])
      if @book && @book.user == current_user
        erb :'books/edit_book'
      else
        redirect to '/books'
      end
    else
      redirect to '/login'
    end
  end

  patch '/books/:slug' do
    if logged_in?
      if params[:content] == ""
        redirect to "/books/#{params[:slug]}/edit"
      else
        @book = Book.find_by_id(params[:slug])
        if @book && @book.user == current_user
          if @book.update(content: params[:content])
            redirect to "/books/#{@book.slug}"
          else
            redirect to "/books/#{@book.slug}/edit"
          end
        else
          redirect to '/books'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/books/:slug/delete' do
    if logged_in?
      @book = Book.find_by_id(params[:id])
      if @book && @book.user == current_user
        @book.delete
      end
      redirect to '/books'
    else
      redirect to '/login'
    end
  end


end
