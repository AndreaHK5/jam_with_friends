class SearchController < ApplicationController
  def index
    some_instrument = params[:instrument]
    @users = Instrument.where(name: some_instrument).first.users
    render 'home/index'
  end
end
