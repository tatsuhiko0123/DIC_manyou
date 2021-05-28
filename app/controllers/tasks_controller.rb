class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = current_user.tasks
    @tasks = @tasks.order(expired_at: :desc) if params[:sort_expired]
    @tasks = @tasks.order(priority: :asc) if params[:sort_priority]

    if params[:search]
      @tasks = @tasks.search_title(params[:search_title]) if params[:search_title]
      @tasks = @tasks.search_status(params[:search_status]) if params[:search_status] != ""
    end

    @tasks = @tasks.page(params[:page]).per(3)
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:title, :content, :expired_at, :status, :priority, :user_id)
  end
  def set_task
    @task = Task.find(params[:id])
  end
end
