class QuestionsController < ApplicationController
  def index
    @questions = Question.all.sort_by { |q| q[:created_at] }
  end

  def show
    @question = Question.find(params[:id])
    @answers = Answer.where(question_id: params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Question was successfully created.'
    else
      @errors = "#{@question.errors.full_messages}"
      render :new
    end
  end

  def question_params
    params.require(:question).permit(:title, :description)
  end

end
