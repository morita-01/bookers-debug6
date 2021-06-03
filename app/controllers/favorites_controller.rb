class FavoritesController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    #if path[:view] == "index.html.erb" && path[:action] == "create"
    #  redirect_to books_path(book)
    #else
    #  redirect_to book_path(book)
    #end
    redirect_to request.referer#遷移元のURLを取得する
  end
  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    #if path[:view] == "index.html.erb" && path[:action] == "destroy"
    #  redirect_to books_path(book)
    #else
    #  redirect_to book_path(book)
    #end
    redirect_to request.referer#遷移元のURLを取得する
  end
end
