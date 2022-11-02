class HomeController < ApplicationController
  before_action :force_json, only: :autocomplete

  def search
    @shows = Show.ransack(title_cont: params[:q]).result(distinct: true)

    respond_to do |format|
      format.html {}
      format.json{ @shows = @shows.limit(5) }
    end
  end

  private
    def force_json
      request.format = :json
    end
end
