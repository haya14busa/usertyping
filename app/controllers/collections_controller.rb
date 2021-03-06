class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy, :play]
  before_action :set_user, except: [:index]
  before_action :authenticate_user, only: [:create, :edit, :update, :destroy]

  def play
  end

  # GET /collections
  # GET /collections.json
  def index
    @collections = Collection.search(params[:query])
  end

  # GET /collections/1
  # GET /collections/1.json
  def show
    @texts = @collection.texts
    # To create texts
    @text = Text.new
    @text.collection = @collection

    respond_to do |format|
      format.html
      format.json {render :json => @collection.as_json(:include => :texts)}
    end
  end

  # GET /collections/1/edit
  def edit
  end

  # POST /collections
  # POST /collections.json
  def create
    @collection = Collection.new(collection_params)

    respond_to do |format|
      if @collection.save
        format.html { redirect_to user_collection_path(@collection.user, @collection), notice: 'Collection was successfully created.' }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/1
  # PATCH/PUT /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to user_collection_path(@collection.user, @collection), notice: 'Collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.json
  def destroy
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to user_collections_url, notice: 'Collection was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def collection_params
      params.require(:collection).permit(:title, :description, :user_id)
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def authenticate_user
      @user = User.find(params[:user_id])
      if @user != current_user
        redirect_to user_collections_url, notice: 'You have no permission'
      end
    end
end
