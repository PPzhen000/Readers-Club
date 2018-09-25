class BooksController < ApplicationController

  get '/books' do
     # binding.pry
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
        if !current_user.books.find_by(title: params[:title])
          @book = current_user.books.create(title: params[:title], author_name: params[:author_name], category_id: params[:category_id], description: params[:description])
          if @book.save
            redirect to '/books'
          end 
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
      if @book
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
      if @book
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
        if @book
          @book.update(title: params[:title], author_name: params[:author_name], category_id: params[:category_id], description: params[:description])
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
     # binding.pry
    if logged_in?
      @book = Book.find_by_slug(params[:slug])
      if @book
        @book.destroy
      end
      redirect to '/books'
    else
      redirect to '/signin'
    end
  end

end
