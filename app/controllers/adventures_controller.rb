class AdventuresController < ApplicationController
  def index
    @adventures = Adventure.all
  end

  def show
    @adventure = Adventure.find(params[:id])

    if current_user
      @first_chapter = Chapter.where(adventure_id: "#{@adventure.id}").first
      @redirection = "/adventures/#{@adventure.id}/chapters/#{@first_chapter.id}"
    else
      @redirection = "/users/sign_up"
    end

  end

  def new
    @adventure = Adventure.new
  end

  def create
    @adventure = Adventure.create(adventure_params)
    redirect_to adventure_design_path(@adventure)
  end

  def design

  end


  private

  def adventure_params
    params.require(:adventure).permit(:title, :synopsis)
  end

end
