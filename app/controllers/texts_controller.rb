class TextsController < ApplicationController
  before_action :set_text, only: [:show, :edit, :update, :destroy]
  before_action :set_user, :set_collection
  before_action :authenticate_user, only: [:create, :edit, :update, :destroy]

  # GET /texts
  # GET /texts.json
  def index
    @texts = Text.all
  end

  # GET /texts/1
  # GET /texts/1.json
  def show
  end

  # GET /texts/1/edit
  def edit
  end

  # POST /texts
  # POST /texts.json
  def create
    @text = Text.new(text_params)

    respond_to do |format|
      if @text.save
        format.html { redirect_to user_collection_path(@user, @collection), notice: 'Text was successfully created.' }
        format.json { render :show, status: :created, location: @text }
      else
        format.html { render :new }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /texts/1
  # PATCH/PUT /texts/1.json
  def update
    respond_to do |format|
      if @text.update(text_params)
        format.html { redirect_to user_collection_text_path(@user, @collection, @text), notice: 'Text was successfully updated.' }
        format.json { render :show, status: :ok, location: @text }
      else
        format.html { render :edit }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /texts/1
  # DELETE /texts/1.json
  def destroy
    @text.destroy
    respond_to do |format|
      format.html { redirect_to user_collection_url(@user, @collection), notice: 'Text was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_text
      @text = Text.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def text_params
      params.require(:text).permit(:title, :body, :description, :collection_id)
    end

    def set_collection
      @collection = Collection.find(params[:collection_id])
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
