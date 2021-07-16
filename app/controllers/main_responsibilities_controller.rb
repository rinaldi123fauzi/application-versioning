class MainResponsibilitiesController < ApplicationController
  before_action :set_main_responsibility, only: %i[ show edit update destroy ]

  # GET /main_responsibilities or /main_responsibilities.json
  def index
    @main_responsibilities = MainResponsibility.all
  end

  # GET /main_responsibilities/1 or /main_responsibilities/1.json
  def show
    @main_responsibility = MainResponsibility.find(params[:id])
    @aktivitas =  if (@main_responsibility.aktivitas.nil? or @main_responsibility.aktivitas.empty?) then
                    ""
                  else
                    @main_responsibility.aktivitas[0, 1] == "[" ? JSON::parse(@main_responsibility.aktivitas) : ""
                  end
  end

  # GET /main_responsibilities/new
  def new
    @main_responsibility = MainResponsibility.new
  end

  # GET /main_responsibilities/1/edit
  def edit
    @main_responsibility = MainResponsibility.find(params[:id])
    @aktivitas =  if (@main_responsibility.aktivitas.nil? or @main_responsibility.aktivitas.empty?) then
                    ""
                  else
                    @main_responsibility.aktivitas[0, 1] == "[" ? JSON::parse(@main_responsibility.aktivitas) : ""
                  end
  end

  # POST /main_responsibilities or /main_responsibilities.json
  def create
    @main_responsibility = MainResponsibility.new(main_responsibility_params)

    unless params[:aktivitas].nil?
      @array = []
      @array = params[:aktivitas]
      @main_responsibility.aktivitas = @array
    end

    respond_to do |format|
      if @main_responsibility.save
        if params[:next_line]
          format.html { redirect_back(fallback_location: root_path, notice: "Form Tanggung Jawab Utama telah dibuat.") }
          format.json { render :show, status: :created, location: @main_responsibility }
        else
          format.html { redirect_to @main_responsibility, notice: "Form Tanggung Jawab Utama telah dibuat." }
          format.json { render :show, status: :created, location: @main_responsibility }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @main_responsibility.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /main_responsibilities/1 or /main_responsibilities/1.json
  def update
    respond_to do |format|
      if @main_responsibility.update(main_responsibility_params)
        unless params[:aktivitas].nil?
          @array = []
          @array = params[:aktivitas]
          @main_responsibility.update(aktivitas: @array)
        end
        if params[:next_line]
          format.html { redirect_back(fallback_location: root_path, notice: "Form Tanggung Jawab Utama telah diubah.") }
          format.json { render :show, status: :created, location: @main_responsibility }
        else
          format.html { redirect_to @main_responsibility, notice: "Form Tanggung Jawab Utama telah diubah." }
          format.json { render :show, status: :ok, location: @main_responsibility }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @main_responsibility.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /main_responsibilities/1 or /main_responsibilities/1.json
  def destroy
    @getResponsibility = MainResponsibility.find(params[:id])
    @arrayData = []
    @arrayData = {
        'Nama : ' => @getResponsibility.staff.try(:nama),
        'Tanggung Jawab : ' => @getResponsibility.try(:periode_waktu),
        'Aktivitas : ' => @getResponsibility.try(:aktivitas),
        'Output : ' => @getResponsibility.try(:output),
        'Periode : ' => @getResponsibility.try(:periode),
        'Frekuensi : ' => @getResponsibility.try(:frekuensi),
        'Menit : ' => @getResponsibility.try(:menit),
        'Issued : ' => @getResponsibility.try(:issued_by)
    }
    setLogActivity("Menghapus data : " + @arrayData.to_s)
    @main_responsibility.destroy
    respond_to do |format|
      format.html { redirect_to main_responsibilities_url, notice: "Main responsibility was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_main_responsibility
      @main_responsibility = MainResponsibility.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def main_responsibility_params
      params.require(:main_responsibility).permit(:staff_id, :tanggung_jawab_utama, :aktivitas, :output, :periode, :frekuensi, :menit, :issued_by ,:nama_pembuat)
    end
end
