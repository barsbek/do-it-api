class CollectionsController < ApplicationController
  before_action :require_login!
  before_action :set_collection, only: [:show, :update, :destroy]

  # GET /collections
  def index
    render json: {
      collections: user_collections,
      page: current_page,
      last_update: last_update
    }
  end

  # GET /collections/1
  def show
    unless(@collection.nil?)
      render json: {
        collection: @collection,
        page: current_page,
        lists: collection_lists,
        last_update: lists_last_update
      }
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
      @current_page || if params[:page].blank?
        @current_page = 1
      else
        @current_page = params[:page]
      end
    end
    # remove pagination
    def user_collections
      current_user.collections
    end

    def last_update
      if user_collections.count > 0
        user_collections.order(:updated_at).last.updated_at
      else
        nil
      end
    end

    def collection_lists
      @collection_lists ||= @collection.lists.page(current_page)
    end

    def lists_last_update
      if collection_lists.count  > 0
        collection_lists.first.updated_at
      else
        nil
      end
    end   

    # Only allow a trusted parameter "white list" through.
    def collection_params
      params.require(:collection).permit(:title, :finish_at, :page)
    end
end
