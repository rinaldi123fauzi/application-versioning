class RisikosController < ApplicationController
  before_action :set_risiko, only: %i[ show edit update destroy ]
  load_and_authorize_resource
  respond_to :html, :json
  
  # GET /risikos or /risikos.json
  def index
    @risikos = Risiko.all
  end

  # GET /risikos/1 or /risikos/1.json
  def show
  end

  # GET /risikos/new
  def new
    @risiko = Risiko.new
  end

  # GET /risikos/1/edit
  def edit
  end

  # POST /risikos or /risikos.json
  def create
    @risiko = Risiko.new(risiko_params)

    respond_to do |format|
      if @risiko.save
        if params[:next_line]
          format.html { redirect_back(fallback_location: root_path, notice: "Risiko was successfully created.") }
          format.json { render :show, status: :created, location: @risiko }
        else
          format.html { redirect_to risikos_path, notice: "Risiko was successfully created." }
          format.json { render :show, status: :created, location: @risiko }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @risiko.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /risikos/1 or /risikos/1.json
  def update
    respond_to do |format|
      if @risiko.update(risiko_params)
        format.html { redirect_to @risiko, notice: "Risiko was successfully updated." }
        format.json { render :show, status: :ok, location: @risiko }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @risiko.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /risikos/1 or /risikos/1.json
  def destroy
    @risiko.destroy
    respond_to do |format|
      format.html { redirect_to risikos_url, notice: "Risiko was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_risiko
      begin
        @risiko = Risiko.find(params[:id])
      rescue
        render_404
      end
    end

    # Only allow a list of trusted parameters through.
    def risiko_params
      params.require(:risiko).permit(:nama, :deskripsi)
    end
end
