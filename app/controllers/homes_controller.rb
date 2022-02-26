class HomesController < ApplicationController #controllerを定義するときは基本的にApplicationControllerを継承する
  protect_from_forgery :except => [:destroy]

  def index #indexメソッドの定義
    #Taskテーブルに保存されている全てのデータを取得してインスタンス変数の@taskに代入する。
    @task = current_user.tasks.page(params[:page]).order(deadline: :asc)
  end

  def sevendays
    @task = current_user.tasks.where(deadline: Date.current..Date.current + 7).page(params[:page]).order(deadline: :asc)
  end

  def new
    @task = Task.new #フォームで必要となるTaskモデルのオブジェクトを作成してインスタンス変数@taskに代入する。
    #このインスタンス変数はビューで参照できる。
  end

  def create
    task = current_user.tasks.new(task_params)
    if task.save
      flash[:notice] = "タスク「#{task.content}」を作成しました"
      redirect_to '/homes'
    else
      redirect_to new_home_path, flash: {
        task: task,
        error_messages: task.errors.full_messages
      }
    end
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    #ローカル変数taskに代入する。updateアクションではviewを作成しないので、インスタンス変数をviewに渡す必要がないため。
    task = current_user.tasks.find(params[:id])
    task.update(task_params)

    if task.save
      flash[:notice] = "タスク「#{task.content}」に変更しました"
      redirect_to '/homes'
    else
      redirect_to edit_home_path, flash: {
        task: task,
        error_messages: task.errors.full_messages
      }
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.delete
    flash[:notice] = "タスク「#{task.content}」を削除しました"
    redirect_to homes_path #'/homes'でもよい
  end

  private

  #特定の値以外保存しないようにフィルターをかけて保存する
  def task_params
    params.require(:task).permit(:content, :deadline, :status)
  end
end