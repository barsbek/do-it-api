class ListsController < ApplicationController
  before_action :require_login!
  before_action :set_list, only: [:show, :update, :destroy, :tasks]

  # GET /lists/1
  def show
    render json: {
      list: @list,
      tasks: @list.tasks,
      last_update: tasks_last_update
    }
  end

  def tasks
    render json: @list.tasks
  end

  # POST /lists
  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id

    if @list.save
      render json: @list, status: :created, location: @list
    else
      render json: { message: "Couldn't create list"},
        status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lists/1
  def update
    if @list.update(list_params)
      render json: @list
    else
      render json: { message: "Couldn't update list"},
        status: :unprocessable_entity
    end
  end

  # DELETE /lists/1
  def destroy
    if @list.destroy
      render json: { list: @list, last_update: last_update(@list.collection_id) }
    else
      render json: { message: "Couldn't remove list" },
        status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = current_user.lists.find(params[:id])
    rescue
      render json: { message: "Couldn't find list" },
        status: :unprocessable_entity
    end

    def last_update(c_id)
      collection = current_user.collections.find(c_id)
      lists = collection.lists
      if(lists.count > 0)
        lists.order(:updated_at).last.updated_at
      else
        nil
      end
    rescue
      render json: { message: "Collection is not found" },
        status: :unprocessable_entity
    end

    def list_tasks
      @list_tasks ||= @list.tasks
    end

    def tasks_last_update
      if(list_tasks.count > 0) 
        list_tasks.order(:updated_at).last.updated_at
      else
        nil
      end
    end


    # Only allow a trusted parameter "white list" through.
    def list_params
      params.require(:list).permit(:title, :collection_id)
    end
end
