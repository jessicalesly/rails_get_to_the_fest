class FestivalsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  def show
    @festival = Festival.find(params[:id])
  end
end
