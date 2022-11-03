class MovieDatabaseAlternativeApiService
  require 'httparty'

  def initialize(params)
    @query   = params[:query]
    p @query
  end

  def get_imdb_id
    headers = {
      "X-RapidAPI-Key": movies_database_api_key,
      "X-RapidAPI-Host": "movie-database-alternative.p.rapidapi.com"
    }
  
    resp = HTTParty.get("https://movie-database-alternative.p.rapidapi.com/?s=#{@query}&r=json&page=1")
  rescue HTTParty::Error => e
    OpenStruct.new({success?: false, error: e})
  else
    results = resp.try(:[], 'Search').try(:[], 0)
  
    return unless results

    title = results.try(:[], 'Title')
    imdb_id = results.try(:[], 'imdbID')
    { title: title, imdb_id: imdb_id }
  end

  def get_results
    headers = {
      "X-RapidAPI-Key": movies_database_api_key,
      "X-RapidAPI-Host": "movie-database-alternative.p.rapidapi.com"
    }

    querystring = {"s": @query, "r": "json", "page": "1"}
  
    resp = HTTParty.get("https://movie-database-alternative.p.rapidapi.com/", headers: headers, query: querystring)
  rescue HTTParty::Error => e
    OpenStruct.new({success?: false, error: e})
  else
    results = resp.try(:[], 'Search')&.map{ |i|  i['Type'] == 'series' ? { title: i['Title'], year: i['Year'], imdb_id: i['imdbID'] } : nil }&.compact
    results = results&.reject { |i| i if Show.find_by_imdb_id(i[:imdb_id]).present? }  # remove shows that are already stored in db
    OpenStruct.new({success?: true, results: results})
  end

  private
    def movies_database_api_key
      ENV['MOVIES_DATABASE_API_KEY']
    end
end