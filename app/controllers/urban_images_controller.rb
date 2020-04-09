class UrbanImagesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy ]
  before_action :set_urban_image, only: [:show, :edit, :update, :destroy]

  # GET /urban_images
  # GET /urban_images.json
  def index
    @city         = City.find(params[:city_id])
    @urban_images = @city.urban_images
  end

  # GET /urban_images/1
  # GET /urban_images/1.json
  def show
  end

  # GET /urban_images/new
  def new
    @city        = City.find(params[:city_id])
    @urban_image = UrbanImage.new
  end

  # GET /urban_images/1/edit
  def edit
  end

  # POST /urban_images
  # POST /urban_images.json
  def create
    
    @city         = City.find(params[:city_id])
    @urban_image = @city.urban_images.build(urban_image_params)
    respond_to do |format|
      if @urban_image.save
        format.html { redirect_to city_urban_images_path(@city), notice: 'Urban image was successfully created.' }
        format.json { render :show, status: :created, location: @urban_image }
      else
        format.html { render :new }
        format.json { render json: @urban_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /urban_images/1
  # PATCH/PUT /urban_images/1.json
  def update
    @city = @urban_image.city
    respond_to do |format|
      if @urban_image.update(urban_image_params)
        format.html { redirect_to city_urban_images_path(@city), notice: 'Urban image was successfully updated.' }
        format.json { render :show, status: :ok, location: @urban_image }
      else
        format.html { render :edit }
        format.json { render json: @urban_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /urban_images/1
  # # DELETE /urban_images/1.json
  # def destroy
  #   @urban_image.destroy
  #   respond_to do |format|
  #     format.html { redirect_to urban_images_url, notice: 'Urban image was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_urban_image
      @urban_image = UrbanImage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def urban_image_params
      params.require(:urban_image).permit(:name, :city_id, files: [])
    end
end
