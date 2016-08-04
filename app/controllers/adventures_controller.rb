class AdventuresController < ApplicationController
  def index
    @adventures = Adventure.all
  end

  def show
    @adventure = Adventure.find(params[:id])
    @first_chapter = Chapter.where(adventure_id: @adventure.id).first
  end

  def new
    @adventure = Adventure.new
  end

  def create
    @adventure = Adventure.new(adventure_params)
    if @adventure.save
      redirect_to adventure_design_path(@adventure.id)
    else
      flash[:notice] = "Adventure title has been used already"
      redirect_to new_adventure_path
    end
  end

  def design
    @adventure = Adventure.find(params[:adventure_id])
    @chapters = Chapter.where(adventure_id: @adventure.id)
    @adventure_id = @adventure.id
  end


  private

  def adventure_params
    params.require(:adventure).permit(:title, :synopsis, :image)
  end
end
