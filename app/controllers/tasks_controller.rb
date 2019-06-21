class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end 
  
  def edit 
    @task = Task.find(params[:id])
  end 
  
  def update 
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success] = "タスクの編集に成功しました"
      redirect_to @task 
    else
      flash.now[:danger] = "タスクの編集に失敗しました"
      render :edit 
    end
  end 
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy 
    flash[:success] = "タスクを削除しました"
    redirect_to  root_url
  end 
  
  def new 
    @task = Task.new
  end 
  
  def create 
    @task = Task.new(task_params)
    
    if @task.save 
       flash[:success] = "タスクを追加しました。"
       redirect_to @task
    else 
      flash.now[:danger] = "タスクを追加できませんでした"
      render :new
    end 
    
  end 
  
  private 
    
    def task_params
      params.require(:task).permit(:content)
    end 
    
  
end
