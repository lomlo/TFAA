class GamesController < ApplicationController

  def index
    p params
    redirect_to '/'
  end

end
