class TasksController < ApplicationController
  before_action :require_login!
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks/1
  def show
    render json: @task
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id

    if @task.save
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    if @task.destroy
      render json: { task: @task, last_update: last_update(@task.list_id) }
    else
      render json: { message: "Coudn't remove task" },
        status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.find(params[:id])
    rescue
      render json: { message: "Couldn't find task" },
        status: :unprocessable_entity
    end

    def last_update(list_id)
      list = current_user.lists.find(list_id)
      tasks = list.tasks
      if(tasks.count > 0)
        tasks.order(:updated_at).last.updated_at
      else
        nil
      end
    rescue
      render json: { message: "List is not found" },
        status: :unprocessable_entity
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:title, :description, :priority, :order, :list_id, :completed)
    end
end
