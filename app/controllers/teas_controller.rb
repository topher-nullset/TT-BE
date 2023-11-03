class TeasController < ApplicationController
  def index
    teas = Tea.all
    render json: teas
  end
end
