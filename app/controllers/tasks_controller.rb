class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    if params[:sort_expired]
      @tasks = Task.order(expired_at: :desc)
    elsif params[:search]
      if params[:search_title].present? && params[:search_status].present?
        @tasks = Task.search_title(params[:search_title]).search_status(params[:search_status])
      elsif params[:search_title].present?
        @tasks = Task.search_title(params[:search_title])
      elsif params[:search_status].present?
        @tasks = Task.search_status(params[:search_status])
      end
    else params[:sort_priority]
      @tasks = Task.order(priority: :asc) 
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを作成しました！"
    else
      render :new
    end

  end

  def self.search(search)
    return Product.all unless search
    Product.where(['name LIKE ?', "%#{search}%"])
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
