module CreateFromApiData
  def create_from_api_data(show, ratings)
    show = Show.find_or_create_by(title: show[:title], imdb_id: show[:imdb_id])
    show_data = ratings.payload
    
    show_data.each do |season, episodes|
      season = Season.create(number: season, show: show)
      
      episodes.each do |episode|
        Episode.create(imdb_rating: episode[:imdb_rating], imdb_id: episode[:imdb_id], season: season)
      end
    end

    show
  end
end
