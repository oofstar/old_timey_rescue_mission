class QuestionsController < ApplicationController
  def index
    @questions = Question.all.sort_by { |q| q[:created_at] }
  end

  def show
    @question = Question.find(params[:id])
    @answers = Answer.where(question_id: params[:id])
  end


end
