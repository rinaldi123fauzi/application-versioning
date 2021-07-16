class RfcsController < ApplicationController
  before_action :set_rfc, only: %i[ show edit update destroy ]
  load_and_authorize_resource
  respond_to :html, :json

  # GET /rfcs or /rfcs.json
  def import
  end

  def index
    unless params[:id_aplikasi].nil?
      unless params[:min].present? or params[:max].present?
        @rfcs = Rfc.where(aplikasi_id: params[:id_aplikasi]).order(:id_status => :asc, :no_registrasi_perubahan => :desc)
        @countRfc = Rfc.order(:no_registrasi_perubahan => :desc).count
        @result = Rfc.where(aplikasi_id: params[:id_aplikasi]).order(:no_registrasi_perubahan => :desc).count
        @app = Aplikasi.find(params[:id_aplikasi])
      else
        @rfcs = Rfc.where('tanggal BETWEEN ? AND ? and aplikasi_id = ?', "#{params[:min]}", "#{params[:max]}", params[:id_aplikasi]).order(:id_status => :asc, :no_registrasi_perubahan => :desc)
        @countRfc = Rfc.order(:no_registrasi_perubahan => :desc).count
        @result = Rfc.where('tanggal BETWEEN ? AND ? and aplikasi_id = ?', "#{params[:min]}", "#{params[:max]}", params[:id_aplikasi]).order(:no_registrasi_perubahan => :desc).count
        @app = Aplikasi.find(params[:id_aplikasi])
      end
    else
      @rfcs = Rfc.order(:id_status => :asc, :no_registrasi_perubahan => :desc).limit(10)
      @countRfc = Rfc.order(:no_registrasi_perubahan => :desc).count
      @result = 10
    end
  end

  # GET /rfcs/1 or /rfcs/1.json
  def show
    @penyelesaians = Penyelesaian.where(rfc_id: params[:id]).select('*')
    @internal_quality_checks = Internal.where(rfc_id: params[:id]).select('*')
    @uats = Uat.where(rfc_id: params[:id]).select('*')
    @changes = Change.where(rfc_id: params[:id]).select('*')

    @uraian_perubahan = if (@rfc.uraian_perubahan.nil? or @rfc.uraian_perubahan.empty?) then
                          ""
                        else
                          @rfc.uraian_perubahan[0, 1] == "[" ? JSON::parse(@rfc.uraian_perubahan) : ""
                        end
    @link = if (@rfc.link.nil? or @rfc.link.empty?) then
                          ""
                        else
                          @rfc.link[0, 1] == "[" ? JSON::parse(@rfc.link) : ""
                        end

    @status_uraian = if (@rfc.status_uraian.nil? or @rfc.status_uraian.empty?) then
                          ""
                        else
                          @rfc.status_uraian[0, 1] == "[" ? JSON::parse(@rfc.status_uraian) : ""
                        end
  end

  # GET /rfcs/new
  def new
    @rfc = Rfc.new
    @no_perubahan = generate_docnum()
  end

  # GET /rfcs/1/edit
  def edit
    @rfc1 = Rfc.find(params[:id])
    @uraian_perubahan = if (@rfc1.uraian_perubahan.nil? or @rfc1.uraian_perubahan.empty?) then
                            ""
                          else
                            @rfc1.uraian_perubahan[0, 1] == "[" ? JSON::parse(@rfc1.uraian_perubahan) : ""
                          end
    @link = if (@rfc1.link.nil? or @rfc1.link.empty?) then
                            ""
                          else
                            @rfc1.link[0, 1] == "[" ? JSON::parse(@rfc1.link) : ""
                          end
    @status_uraian = if (@rfc1.status_uraian.nil? or @rfc1.status_uraian.empty?) then
                            ""
                          else
                            @rfc1.status_uraian[0, 1] == "[" ? JSON::parse(@rfc1.status_uraian) : ""
                          end
  end

  # POST /rfcs or /rfcs.json
  def create
    @rfc = Rfc.new(rfc_params)
    
    unless params[:uraian_perubahan].nil?
      @array = []
      @array = params[:uraian_perubahan]
      @rfc.uraian_perubahan = @array
    end

    unless params[:link].nil?
      @array = []
      @array = params[:link]
      @rfc.link = @array
    end

    unless params[:status_uraian].nil?
      @array = []
      @array = params[:status_uraian]
      @rfc.status_uraian = @array
    end
    
    respond_to do |format|
      if @rfc.save
        if params[:next_line]
          format.html { redirect_back(fallback_location: root_path, notice: "Rfc was successfully created.") }
          format.json { render :show, status: :created, location: @rfc }
        else
          format.html { redirect_to @rfc, notice: "Rfc was successfully created." }
          format.json { render :show, status: :created, location: @rfc }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rfc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rfcs/1 or /rfcs/1.json
  def update
    respond_to do |format|
      if @rfc.update(rfc_params)
        
        unless params[:uraian_perubahan].nil?
          @array = []
          @array = params[:uraian_perubahan]
          @rfc.update(uraian_perubahan: @array)
        end

        unless params[:link].nil?
          @array = []
          @array = params[:link]
          @rfc.update(link: @array)
        end

        unless params[:status_uraian].nil?
          @array = []
          @array = params[:status_uraian]
          @rfc.update(status_uraian: @array)
        end

        if params[:next_line]
          format.html { redirect_back(fallback_location: root_path, notice: "Rfc was successfully created.") }
          format.json { render :show, status: :created, location: @rfc }
        else
          format.html { redirect_to @rfc, notice: "Rfc was successfully updated." }
          format.json { render :show, status: :ok, location: @rfc }
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rfc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rfcs/1 or /rfcs/1.json
  def destroy
    @getStatus = Rfc.find(params[:id]) 
    
    unless @getStatus.status != "Open"
      @penyelesaian = Penyelesaian.find_by(rfc_id: params[:id])
      @penyelesaian ? @internal = Internal.find_by(penyelesaian_id: @penyelesaian.id) : ""
      @internal ? @uat = Uat.find_by(internal_id: @internal.id) : ""
      @uat ? @change = Change.find_by(uat_id: @uat.id) : ""
      @change.present? ? @change.destroy : ""
      @uat.present? ? @uat.destroy : ""
      @internal.present? ? @internal.destroy : ""
      @penyelesaian.present? ? @penyelesaian.destroy : ""
      @rfc.destroy
      respond_to do |format|
        format.html { redirect_to rfcs_url, notice: "Rfc was successfully destroyed." }
        format.json { head :no_content }
      end
    else
      redirect_to rfcs_url, notice: "Rfc cannot destroy."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rfc
      begin
        @rfc = Rfc.find(params[:id])
      rescue
        render_404
      end
    end

    # Only allow a list of trusted parameters through.
    def rfc_params
      params.require(:rfc).permit(:no_registrasi_perubahan, :versi_aplikasi, :uraian_perubahan, :link, :tanggal, :priority_id, :category_id, :risiko_id, :rfcs_import, :aplikasi_id, :issued_by, :nama_user)
    end

    def generate_docnum
      separator = "-"
      year = Time.now.strftime("%y")
      tgl = Rfc.maximum("tanggal")
      if tgl.is_a? String
        tgl = Date.parse(tgl)
      end
      docnum = "RFC" + separator + "APP" + separator + year
      rfc = Rfc.last
      sequence_number = "001"
      
      if Rfc.exists? and (Time.now.year.to_s <= tgl.strftime("%Y"))
        split = rfc.no_registrasi_perubahan.split('-')
        sequence_number = split[3]
        int_sequence_number = Integer(sequence_number, 10) + 1
        zero_length = 2 - rfc.no_registrasi_perubahan[0..2].to_i

        i = 0
        sequence_number = ""
        while i < zero_length  do
          sequence_number1 = split[3]
          if sequence_number1 >= "009" and sequence_number1 <= "098"
            sequence_number = "0"
          elsif sequence_number1 >= "099"
            sequence_number = ""
          else
            sequence_number += "0"
          end
          i +=1
        end
        sequence_number += int_sequence_number.to_s
      
      end
      docnum = docnum + separator + sequence_number
      return docnum
    end
end
