class IndicatorsController < ApplicationController
  def latest
    @indicator = Indicator.last
    render json: @indicator
  end
end
