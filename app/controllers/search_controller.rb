class SearchController < ApplicationController
  def index
    render locals: {
      facade: StationsFacade.new(params[:q])
    }
  end
end
