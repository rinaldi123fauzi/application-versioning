class AuditTrailsController < ApplicationController
  before_action :set_audit_trail, only: %i[ show edit update destroy ]

  # GET /audit_trails or /audit_trails.json
  def index
    @audit_trails = AuditTrail.all
  end

  # GET /audit_trails/1 or /audit_trails/1.json
  def show
  end

  # GET /audit_trails/new
  def new
    @audit_trail = AuditTrail.new
  end

  # GET /audit_trails/1/edit
  def edit
  end

  # POST /audit_trails or /audit_trails.json
  def create
    @audit_trail = AuditTrail.new(audit_trail_params)

    respond_to do |format|
      if @audit_trail.save
        format.html { redirect_to @audit_trail, notice: "Audit trail was successfully created." }
        format.json { render :show, status: :created, location: @audit_trail }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @audit_trail.errors, status: :unprocessable_entity }
      end
    end
  end

  # # PATCH/PUT /audit_trails/1 or /audit_trails/1.json
  # def update
  #   respond_to do |format|
  #     if @audit_trail.update(audit_trail_params)
  #       format.html { redirect_to @audit_trail, notice: "Audit trail was successfully updated." }
  #       format.json { render :show, status: :ok, location: @audit_trail }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @audit_trail.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /audit_trails/1 or /audit_trails/1.json
  # def destroy
  #   @audit_trail.destroy
  #   respond_to do |format|
  #     format.html { redirect_to audit_trails_url, notice: "Audit trail was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_audit_trail
      @audit_trail = AuditTrail.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def audit_trail_params
      params.require(:audit_trail).permit(:user, :description, :controller, :action, :browser, :ip_address)
    end
end
