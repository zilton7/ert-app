class TablesController < ApplicationController
  include CreateFromApiData

  def index
    query = params[:search]
    @shows = Show.ransack(title_cont: query).result(distinct: true)
    
    unless @shows.any?
      if query
        @shows = MovieDatabaseAlternativeApiService.new({query: query}).get_results.results
      end
    else
      @shows
    end
  end

  def show
    @show_data = Show.find(params[:id])
  end

  def build
    title = params[:title]
    imdb_id = params[:imdb_id]
    show_data = { title: title, imdb_id: imdb_id }
    ratings_data = MoviesDatabaseApiService.new({ imdb_id: show_data[:imdb_id] }).get_seasons_episodes_ratings
    @show = create_from_api_data(show_data, ratings_data)
    if @show.present?
      redirect_to table_path(@show)
    end
  end

  def search
    @shows = Show.ransack(title_cont: params[:q]).result(distinct: true)

    respond_to do |format|
      format.html {}
      format.json{ @shows = @shows.limit(5) }
    end
  end

  private

    def table_params
      params.fetch(:table, {}).permit(:search)
    end
end
