module TablesHelper
  def generate_table(data)
    seasons = {}
    data.seasons.each do |s|
      seasons[s.number] = s.episodes.map{|e| { imdb_rating: e.imdb_rating, imdb_id: e.imdb_id } }
    end

    longest = seasons.values.max_by(&:length).length
    range = (1..longest).to_a

    table = []

    top_row = seasons.keys.map{ |s| "<th  style='color: white; background-color: black; text-align: center;' title='season #{s.to_s}'>" + s.to_s + '</th>' }
    table.append('<thead><th style="color: white; background-color: black; text-align: center;"></th>' + top_row.join('') + '</thead>')

    range.each do |i|
      row = ["<th style='color: white; background-color: black; text-align: center;' title='episode #{i}'>#{i}</th>"]
      seasons.keys.each do |key|
        imdb_rating = seasons[key][i-1].try(:[], :imdb_rating)
        imdb_id = seasons[key][i-1].try(:[], :imdb_id)
        if imdb_rating
          td = "<td style='#{highlight_cell(imdb_rating)} cursor: pointer;' onclick=#{generate_onclick(imdb_id)} title='season #{key} episode #{i}'>#{imdb_rating}</t=></td>"
        else
          td = "<td></td>"
        end
        row.append(td)
      end

      table.append("<tr>" + row.join('') + "</tr>")
    end

    
    "<table class='table table-bordered'>#{table.join('')}</table>".html_safe
  end

  def highlight_cell(val)
    if val >= 8.6
      color = 'MediumSeaGreen'
    elsif val >= 7.6
      color = 'yellow'
    elsif val >= 6.6
      color = 'orange'
    elsif val >= 5.6
      color = 'IndianRed'
    else
      color = 'MediumSlateBlue'
    end

    "text-align: center; background-color: #{color};"
  end

  def generate_onclick(imdb_id)
    "window.open('https://www.imdb.com/title/#{imdb_id}/')"
  end

  def build_table_link(api_show)
    link_to("Build for '#{api_show[:title]} (#{api_show[:year]})'", build_path(title: api_show[:title], imdb_id: api_show[:imdb_id], year: api_show[:year]))
  end
end
