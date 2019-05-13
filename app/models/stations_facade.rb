class StationsFacade
  def initialize(zip_code)
    @zip_code = zip_code
  end

  def total_results
    conn = Faraday.new('https://developer.nrel.gov/api/alt-fuel-stations/v1/nearest.json') do |f|
      f.adapter Faraday.default_adapter
      f.params['api_key'] = ENV['nrel_api_key']
      f.params['location'] = @zip_code
      f.params['radius'] = 5.0
      f.params['fuel_type'] = 'ELEC,LPG'
      f.params['access'] = 'public'
    end

    response = conn.get
    JSON.parse(response.body, symbolize_names: true)[:station_counts][:total]
  end

  def stations

  end
end
