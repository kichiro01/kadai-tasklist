class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  
  def index
    @tasks = Task.order(created_at: :desc).page(params[:page])
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = "タスクが作成されました。"
      redirect_to @task
    else
      flash.now[:danger] = "タスクの作成に失敗しました。"
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = "タスクは正常に更新されました。"
      redirect_to @task
    else
      flash.now[:danger] = "タスクの更新に失敗しました。"
      rener :edit
    end
  end
  
  def destroy
    @task.destroy
    flash[:success] = "タスクは正常に削除されました。"
    redirect_to tasks_path
  end
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
