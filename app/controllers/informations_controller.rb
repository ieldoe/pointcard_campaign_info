class InformationsController < ApplicationController
  def index
    @dpoints = Dpoint.all
    @pay_images = Paypayimage.all
    @pay_info = Paypaypoint.all
    @tpoints = Tpoint.all
  end
end
