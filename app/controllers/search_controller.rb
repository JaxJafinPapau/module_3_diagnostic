class SearchController < ApplicationController
  def index
    facade = Facade.new(params[:q])
    render locals: {
      station_count: facade.station_count,
      stations: facade.get_stations
    }
  end
end
