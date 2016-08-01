class ChaptersController < ApplicationController

  before_action :authenticate_user!

  def show
    game = Game.where(adventure_id: params[:adventure_id], user_id: current_user.id)
    if game.count == 1
      @chapter = Chapter.find(game.first.chapters.split("").last.to_i)
      @choices = Choice.where(chapter_id: "#{@chapter.id}")
    else
      @chapter = Chapter.find(params[:id])
      @choices = Choice.where(chapter_id: "#{@chapter.id}")
      Game.create(chapters: params[:id], adventure_id: @chapter.adventure_id, user_id: current_user.id)
    end
  end


end
