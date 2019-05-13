class NrelService
  def initialize(zip_code)
    @zip_code = zip_code
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

  def retrieve(query_param, limit = nil)
    response = conn.get
    json_response = JSON.parse(response.body, symbolize_names: true)[query_param]

    if limit
      json_response.take(limit)
    else
      json_response
    end
  end
end
