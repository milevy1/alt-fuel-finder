class StationsFacade
  def initialize(zip_code)
    @zip_code = zip_code
  end

  def total_results
    JSON.parse(response.body, symbolize_names: true)[:total_results]
  end

  def stations
    nearest_15_stations = JSON.parse(response.body, symbolize_names: true)[:fuel_stations].take(15)

    nearest_15_stations.map do |station_data|
      Station.new(station_data)
    end
  end

  def conn
    Faraday.new('https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json') do |f|
      f.adapter Faraday.default_adapter
      f.params['api_key'] = ENV['nrel_api_key']
      f.params['location'] = @zip_code
      f.params['radius'] = 5.0
      f.params['fuel_type'] = 'ELEC,LPG'
      f.params['access'] = 'public'
    end
  end

  def response
    conn.get
  end
end
