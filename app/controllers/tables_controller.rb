class TablesController < ApplicationController
  def show
    @result = MoviesDatabaseApiService.new({
      imdb_id: params[:id]
    }).call
  end
end
