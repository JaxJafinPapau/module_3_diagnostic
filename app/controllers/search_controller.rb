class SearchController < ApplicationController
  def index
    render locals: {
      stations: Facade.new
    }
  end
end
