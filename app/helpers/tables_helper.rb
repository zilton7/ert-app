module TablesHelper
  def generate_table(data)
    seasons = {}
    data.seasons.each do |s|
      seasons[s.number] = s.episodes.map{|e| e.imdb_rating}
    end

    longest = seasons.values.max_by(&:length).length
    range = (1..longest).to_a

    table = []

    top_row = seasons.keys.map{ |s| "<th  style='color: white; background-color: black; text-align: center;'>" + s.to_s + '</th>' }
    table.append('<thead><th style="color: white; background-color: black; text-align: center;"></th>' + top_row.join('') + '</thead>')

    range.each do |i|
      row = ["<th style='color: white; background-color: black; text-align: center;'>#{i}</th>"]
      seasons.keys.each do |key|
        rating = seasons[key][i-1]
        if rating
          td = "<td style='#{highlight_cell(rating)}'>#{rating}</td>"
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
end
