class MovieDatabaseAlternativeApiService
  require 'httparty'

  def initialize(params)
    @query   = params[:query]
  end

  def get_imdb_id
    headers = {
      "X-RapidAPI-Key": movies_database_api_key,
      "X-RapidAPI-Host": "movie-database-alternative.p.rapidapi.com"
    }

    querystring = {"s": @query, "r": "json", "page": "1"}
  
    resp = HTTParty.get("https://movie-database-alternative.p.rapidapi.com/", headers: headers, query: querystring)
  rescue HTTParty::Error => e
    OpenStruct.new({success?: false, error: e})
  else
    { title: resp['Search'][0]['Title'], imdb_id: resp['Search'][0]['imdbID'] }
  end

  private
    def movies_database_api_key
      ENV['MOVIES_DATABASE_API_KEY']
    end
end