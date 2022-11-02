class TablesController < ApplicationController
  include CreateFromApiData

  def index
    @show_data = Show.search(params[:search])
  end

  def show
    # q = params[:query]&.downcase
    # @show_data = Show.where("title ilike ?", "%#{q}%").first
    @show_data = Show.search(params[:search])

    unless @show_data
      show_data = MovieDatabaseAlternativeApiService.new({query: params[:query]}).get_imdb_id
      ratings_data = MoviesDatabaseApiService.new({imdb_id: show_data[:imdb_id]}).get_seasons_episodes_ratings
      
      @show_data = create_from_api_data(show_data, ratings_data)
    else
      @show_data
    end
  end

  private

    def table_params
      params.fetch(:table, {}).permit(:search)
    end
end
