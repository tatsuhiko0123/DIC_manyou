class TasksController < ApplicationController
  def index
    @tasks = Task.all
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

  def show
    @task = task.find(params[:id])
  end

  def edit
  end

  private
  def task_params
    params.require(:task).permit(:title, :content)
  end
end
