class MoviesDatabaseApiService
 
  require 'httparty'

  def initialize(params)
    @imdb_id   = params[:imdb_id]
  end

  def call
    headers = {
      "X-RapidAPI-Key": movies_database_api_key,
      "X-RapidAPI-Host": "moviesdatabase.p.rapidapi.com"
  }
  
    result = HTTParty.get("https://moviesdatabase.p.rapidapi.com/titles/series/#{@imdb_id}", headers: headers)
  rescue HTTParty::Error => e
    OpenStruct.new({success?: false, error: e})
  else
    # results = json.loads(resp.text)['results']
    # season_episodes = {}
    # for result in results:
    #     if not result['seasonNumber'] in season_episodes:
    #         print('Working on season:', result['seasonNumber'])
    #         season_episodes[result['seasonNumber']] = []
    #     print('episode', result['episodeNumber'])
    #     season_episodes[result['seasonNumber']].append(get_rating(result['tconst']))
    # return season_episodes
    OpenStruct.new({success?: true, payload: result})
  end

  private

    def movies_database_api_key
      ENV['MOVIES_DATABASE_API_KEY']
    end

end