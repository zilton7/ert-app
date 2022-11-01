class MoviesDatabaseApiService
 
  require 'httparty'

  def initialize(params)
    @imdb_id   = params[:imdb_id]
  end

  def get_seasons_episodes_ratings
    headers = {
      "X-RapidAPI-Key": movies_database_api_key,
      "X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com"
  }
  
    resp = HTTParty.get("https://moviesdatabase.p.rapidapi.com/titles/series/#{@imdb_id}", headers: headers)
  rescue HTTParty::Error => e
    OpenStruct.new({success?: false, error: e})
  else
    results = resp['results']
    season_episodes = {}
    results.each do |result|
      unless season_episodes.key?(result['seasonNumber'])
        season_episodes[result['seasonNumber']] = []
      end
      season_episodes[result['seasonNumber']] << (get_rating(result['tconst']))
    end

    OpenStruct.new({success?: true, payload: season_episodes})
  end

  private

    def get_rating(imdb_id)
      url = "https://moviesdatabase.p.rapidapi.com/titles/#{imdb_id}/ratings"
      headers = {
          "X-RapidAPI-Key": movies_database_api_key,
          "X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com"
      }

      resp = HTTParty.get(url, headers: headers)
      
      rescue HTTParty::Error => e
        OpenStruct.new({success?: false, error: e})
      else
        resp.try(:[],'results').try(:[], 'averageRating')
      

    end

    def movies_database_api_key
      ENV['MOVIES_DATABASE_API_KEY']
    end

end