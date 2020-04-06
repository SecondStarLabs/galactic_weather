class BackgroundPhotosController < ApplicationController
  before_action :set_background_photo, only: [:show, :edit, :update, :destroy]

  # GET /background_photos
  # GET /background_photos.json
  def index
    @background_photos = BackgroundPhoto.all
  end

  # GET /background_photos/1
  # GET /background_photos/1.json
  def show
  end

  # GET /background_photos/new
  def new
    @background_photo = BackgroundPhoto.new
  end

  # GET /background_photos/1/edit
  def edit
  end

  # POST /background_photos
  # POST /background_photos.json
  def create
    @background_photo = BackgroundPhoto.new(background_photo_params)

    respond_to do |format|
      if @background_photo.save
        format.html { redirect_to @background_photo, notice: 'Background photo was successfully created.' }
        format.json { render :show, status: :created, location: @background_photo }
      else
        format.html { render :new }
        format.json { render json: @background_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /background_photos/1
  # PATCH/PUT /background_photos/1.json
  def update
    respond_to do |format|
      if @background_photo.update(background_photo_params)
        format.html { redirect_to @background_photo, notice: 'Background photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @background_photo }
      else
        format.html { render :edit }
        format.json { render json: @background_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /background_photos/1
  # DELETE /background_photos/1.json
  def destroy
    @background_photo.destroy
    respond_to do |format|
      format.html { redirect_to background_photos_url, notice: 'Background photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_background_photo
      @background_photo = BackgroundPhoto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def background_photo_params
      params.require(:background_photo).permit(:name, :source_url, files: [])
    end
end
