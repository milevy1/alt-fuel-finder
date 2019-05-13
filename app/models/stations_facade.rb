class StationsFacade
  def initialize(zip_code)
    @zip_code = zip_code
  end

  def total_results
    nrel_total_results
  end

  def stations
    nrel_nearby_stations.map do |station_data|
      Station.new(station_data)
    end
  end

  private

  def nrel_service
    @nrel_service ||= NrelService.new(@zip_code)
  end

  def nrel_total_results
    @nrel_total_results ||= nrel_service.retrieve(:total_results)
  end

  def nrel_nearby_stations
    @nrel_nearby_stations ||= nrel_service.retrieve(:fuel_stations, 15)
  end
end
