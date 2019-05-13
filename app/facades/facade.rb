class Facade

  def initialize(zip_code)
    @zip_code = zip_code
  end

  def get_stations
    response["fuel_stations"].map do |station|
      Station.new(
        station["station_name"],
        station["street_address"],
        station["fuel_type_code"],
        station["distance"],
        station["access_days_time"]
      )
    end
  end

  def station_count
    response["total_results"]
  end

  private

  def response
    JSON.parse(conn.body)
  end


  def conn
    Faraday.get("https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json?fuel_type=LPG,ELEC&limit=15&api_key=#{ENV['API_KEY']}&format=JSON&status=E&location=#{@zip_code}&radius=5.0&access=public")
  end
end
