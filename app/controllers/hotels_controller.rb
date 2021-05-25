class HotelsController < ApplicationController

  def index
  end

  private
    def hotel_params
      params.fetch(:hotel, {})
    end
end
