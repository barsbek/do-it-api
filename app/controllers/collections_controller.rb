class CollectionsController < ApplicationController
  before_action :require_login!
  before_action :set_collection, only: [:show, :update, :destroy]

  # GET /collections
  def index
    @collections = user_collections.page(current_page)

    render json: {
      collections: @collections,
      last_update: last_update
    }
  end

  # GET /collections/1
  def show
    unless(@collection.nil?)
      render json: { collection: @collection, lists: @collection.lists.page(1) }
    else
      render json: { message: "Collection is not found" },
        status: :not_found 
    end
  end

  # POST /collections
  def create
    @collection = Collection.new(collection_params)
    @collection.user_id = current_user.id
    if @collection.save
      render json: @collection, status: :created, location: @collection
    else
      render json: @collection.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /collections/1
  def update
    if @collection.update(collection_params)
      render json: @collection
    else
      render json: @collection.errors, status: :unprocessable_entity
    end
  end

  # DELETE /collections/1
  def destroy
    render json: { collection: @collection.destroy, last_update: last_update }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = user_collections.detect{ |c| c.id.to_s == params[:id] }
    end

    def current_page
      return 1 if params[:page].blank?
      params[:page]
    end

    def user_collections
      current_user.collections
    end

    def last_update
      user_collections.order(:updated_at).last.updated_at
    end      

    # Only allow a trusted parameter "white list" through.
    def collection_params
      params.require(:collection).permit(:title, :finish_at, :page)
    end
end
