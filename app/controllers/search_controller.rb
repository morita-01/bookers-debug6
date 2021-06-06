class SearchController < ApplicationController
  def search
    @range = params[:range]
    search = params[:search]
    word = params[:word]
    if @range == "User"
      @users = User.looks(search, word)
    else
      @books = Book.looks(search, word)
    end
  #@keyword = params[:keyword]
  #render "search"
  end
end
