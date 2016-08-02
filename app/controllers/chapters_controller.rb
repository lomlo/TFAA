class ChaptersController < ApplicationController

  before_action :authenticate_user!

  def show
    game = Game.where(adventure_id: params[:adventure_id], user_id: current_user.id).first
    if game
      update_game(game)
      @chapter = Chapter.find(game.chapters.split(',').last)
      @choices = Choice.where(chapter_id: @chapter.id)
    else
      Game.create(chapters: params[:id], choices: "", adventure_id: params[:adventure_id], user_id: current_user.id)
      @chapter = Chapter.find(params[:id])
      @choices = Choice.where(chapter_id: @chapter.id)
    end
  end

private

  def update_game(game)
    choice = Choice.where(chapter_id: game.chapters.split(',').last, resulting_chapter_id: params[:id]).first
    game.update(chapters: game.chapters + ",#{params[:id]}", choices: game.choices + ",#{choice.id}" ) if choice
  end

end
