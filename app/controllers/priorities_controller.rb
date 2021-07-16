class PrioritiesController < ApplicationController
  before_action :set_priority, only: %i[ show edit update destroy ]
  load_and_authorize_resource
  respond_to :html, :json
  
  # GET /priorities or /priorities.json
  def index
    @priorities = Priority.all
  end

  # GET /priorities/1 or /priorities/1.json
  def show
  end

  # GET /priorities/new
  def new
    @priority = Priority.new
  end

  # GET /priorities/1/edit
  def edit
  end

  # POST /priorities or /priorities.json
  def create
    @priority = Priority.new(priority_params)

    respond_to do |format|
      if @priority.save
        if params[:next_line]
          format.html { redirect_back(fallback_location: root_path, notice: "Priority was successfully created.") }
          format.json { render :show, status: :created, location: @priority }
        else
          format.html { redirect_to @priority, notice: "Priority was successfully created." }
          format.json { render :show, status: :created, location: @priority }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @priority.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /priorities/1 or /priorities/1.json
  def update
    respond_to do |format|
      if @priority.update(priority_params)
        format.html { redirect_to @priority, notice: "Priority was successfully updated." }
        format.json { render :show, status: :ok, location: @priority }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @priority.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /priorities/1 or /priorities/1.json
  def destroy
    @priority.destroy
    respond_to do |format|
      format.html { redirect_to priorities_url, notice: "Priority was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_priority
      begin
        @priority = Priority.find(params[:id])
      rescue
        render_404
      end
    end

    # Only allow a list of trusted parameters through.
    def priority_params
      params.require(:priority).permit(:nama, :deskripsi)
    end
end
