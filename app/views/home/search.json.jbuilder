json.shows do
  json.array!(@shows) do |show|
    json.title show.title
    json.url table_path(query: show.imdb_id)
  end
end