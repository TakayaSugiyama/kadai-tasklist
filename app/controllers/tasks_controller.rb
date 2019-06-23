class TasksController < ApplicationController
  before_action :require_login #ログインユーザーのみに許可
  before_action :current_user  #現在ログインしているユーザー
  before_action :not_permission_without_post_user, only: [:show,:edit,:update,:destroy]      # タスク投稿者以外禁止
  
  
  def index
    @tasks = @current_user.tasks.all
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
    @task =  @current_user.tasks.build(task_params)
    
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
      params.require(:task).permit(:content,:status,:user)
    end 
    
    # タスク投稿者以外禁止
   def  not_permission_without_post_user
     task = Task.find(params[:id])
     if @current_user.id != task.user_id 
       flash[:danger] = "許可がありません"
       redirect_to root_url
     end
   end

end
