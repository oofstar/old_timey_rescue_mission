class AnswersController < ApplicationController
  def index
    @question = Question.find(params[:question_id])
    @answers = @question.answers
  end

  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question


    if @answer.save
      @message = "Answer successfully saved"
      redirect_to question_path(@question)
    else
      @message = "#{@answer.errors.full_messages}"
      render :new
    end
  end

  def answer_params
    params.require(:answer).permit(:description)
  end
end
