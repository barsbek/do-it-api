class ListsController < ApplicationController
  before_action :require_login!
  before_action :set_list, only: [:show, :update, :destroy, :tasks]

  # GET /lists
  def index
    @lists = List.all

    render json: @lists
  end

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
    render json: {
      list: @list.destroy,
      last_update: last_update(@list.collection_id)
    }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    rescue
      render json: { message: "Couldn't find list" },
        status: :unprocessable_entity
    end

    def last_update(collection_id)
      # TODO: optimize
      lists = Collection.find(collection_id).lists
      if(lists.count > 0)
        lists.order(:updated_at).last.updated_at
      else
        nil
      end
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
