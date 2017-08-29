class QuestionsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all.sort_by { |q| q[:created_at] }
  end

  def show
    @question = Question.find(params[:id])
    @answers = Answer.where(question_id: params[:id])
    @answer = Answer.new
  end

  def new
    @question = Question.new()
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question
    else
      redirect_to new_question_path, notice: "#{@question.errors.full_messages}"
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update

    @question = Question.find(params[:id])
    @question.update(question_params)

    if @question.save
      redirect_to @question, notice: "Question successfully edited"
    else
      redirect_to edit_question_path, notice: "#{@question.errors.full_messages}"
    end
  end

  def destroy
    @question.answers.destroy_all
    @question.destroy
    redirect_to questions_path, notice: 'Event was successfully destroyed.'
  end


  private
  def set_event
    @question = Question.find(params[:id])

  end

  def question_params
    params.require(:question).permit(:title, :description)
  end

end
