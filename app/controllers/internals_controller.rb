class InternalsController < ApplicationController
  before_action :set_internal, only: %i[ show edit update destroy ]
  load_and_authorize_resource
  respond_to :html, :json
  
  # GET /internals or /internals.json
  def index
    @internals = Internal.all
  end

  # GET /internals/1 or /internals/1.json
  def show
  end

  # GET /internals/new
  def new
    @internal = Internal.new
  end

  # GET /internals/1/edit
  def edit
  end

  # POST /internals or /internals.json
  def create
    @internal = Internal.new(internal_params)
    respond_to do |format|
      if @internal.save
        if params[:next_line]
          format.html { redirect_to "/uats/" + params[:internal][:id_rfc] + "/new_uat", notice: "QC was successfully created." }
          format.json { render :show, status: :created, location: @internal }
        else
          format.html { redirect_to rfc_path(params[:internal][:id_rfc]), notice: "QC was successfully created." }
          format.json { render :show, status: :created, location: @internal }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @internal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /internals/1 or /internals/1.json
  def update
    respond_to do |format|
      if @internal.update(internal_params)
        format.html { redirect_to @internal, notice: "Internal was successfully updated." }
        format.json { render :show, status: :ok, location: @internal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @internal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /internals/1 or /internals/1.json
  def destroy
    @internal.destroy
    respond_to do |format|
      format.html { redirect_to internals_url, notice: "Internal was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_internal
      begin
        @internal = Internal.find(params[:id])
      rescue
        render_404
      end
    end

    # Only allow a list of trusted parameters through.
    def internal_params
      params.require(:internal).permit(:tgl_testing, :penguji, :id_rfc)
    end
end
