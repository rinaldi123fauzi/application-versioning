class AplikasisController < ApplicationController
  before_action :set_aplikasi, only: %i[ show edit update destroy ]
  load_and_authorize_resource
  respond_to :html, :json
  
  # GET /aplikasis or /aplikasis.json
  # def contoh
  #   separator = "."
  #     sequence_number = "00"

  #     rfc = Rfc.where(aplikasi_id: id_aplikasi).last

  #     a = rfc.versi_aplikasi.split('.')
  #     b = a[3]

  #     if rfc.present?
  #       if a[2] == "9"
  #         split = rfc.versi_aplikasi.split('.')
  #         sequence_number = split[1]
  #         int_sequence_number = Integer(sequence_number, 10) + 1
  #         zero_length = 1 - rfc.versi_aplikasi[0..1].to_i

  #         i = 0
  #         sequence_number = ""
  #         while i < zero_length  do
  #           if int_sequence_number.to_s <= "08"
  #             sequence_number = "0"
  #           end
  #           i +=1
  #         end
  #         major = sequence_number += int_sequence_number.to_s
  #         minor = "0"
  #         sequence_number = "00"
  #       end 

  #       if a[2] != "9" and b[2..3] >= "98"
  #         split = rfc.versi_aplikasi.split('.')
  #         sequence_number = split[2]
  #         int_sequence_number = Integer(sequence_number, 10) + 1
  #         zero_length = 1 - rfc.versi_aplikasi[0..1].to_i

  #         i = 0
  #         sequence_number = ""
  #         while i < zero_length  do
  #           if int_sequence_number.to_s <= "08"
  #             sequence_number = "0"
  #           end
  #           i +=1
  #         end
  #         major = split[1]
  #         minor = sequence_number += int_sequence_number.to_s
  #         sequence_number = "00"
  #       end 
        
  #       if b[2..3] <= "98"
  #         split = rfc.versi_aplikasi.split('.')
  #         sequence_number = split[3]
  #         getSequence = sequence_number[2..3]
  #         int_sequence_number = Integer(sequence_number[2..3], 10) + 1
  #         zero_length = 2 - rfc.versi_aplikasi[0..2].to_i

  #         i = 0
  #         sequence_number = ""
  #         while i < zero_length  do
  #           if getSequence <= "08"
  #             sequence_number = "0"
  #           end
  #           i +=1
  #         end
  #         major = split[1]
  #         minor = split[2]
  #         sequence_number += int_sequence_number.to_s
  #       end
  #     end
  #     docnum = "V" + separator + major + separator + minor + separator + @app.id_aplikasi + sequence_number
  #     render :json => docnum.to_json
  # end

  def setVersiAplikasi
    id_aplikasi = params[:id]
    @app = Aplikasi.find(id_aplikasi)
    unless Rfc.exists?(aplikasi_id: id_aplikasi)
      render :json => @app.default_version.to_json
    else
      @checking = Rfc.where(aplikasi_id: id_aplikasi).last
      if @checking.status == "Closed"
        @getRelease = Change.where(aplikasi_id: id_aplikasi).order(:versi_sourcecode => :asc).last
        render :json => @getRelease.versi_sourcecode.to_json
      else
        render :json => @checking.versi_aplikasi.to_json
      end
    end
  end

  def index
    @aplikasis = Aplikasi.order(:id_aplikasi => :asc)
  end

  # GET /aplikasis/1 or /aplikasis/1.json
  def show
  end

  # GET /aplikasis/new
  def new
    @aplikasi = Aplikasi.new
  end

  # GET /aplikasis/1/edit
  def edit
  end

  # POST /aplikasis or /aplikasis.json
  def create
    @aplikasi = Aplikasi.new(aplikasi_params)

    respond_to do |format|
      if @aplikasi.save
        format.html { redirect_to @aplikasi, notice: "Aplikasi was successfully created." }
        format.json { render :show, status: :created, location: @aplikasi }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @aplikasi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /aplikasis/1 or /aplikasis/1.json
  def update
    respond_to do |format|
      if @aplikasi.update(aplikasi_params)
        format.html { redirect_to @aplikasi, notice: "Aplikasi was successfully updated." }
        format.json { render :show, status: :ok, location: @aplikasi }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @aplikasi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /aplikasis/1 or /aplikasis/1.json
  # def destroy
  #   @aplikasi.destroy
  #   respond_to do |format|
  #     format.html { redirect_to aplikasis_url, notice: "Aplikasi was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aplikasi
      begin
        @aplikasi = Aplikasi.find(params[:id])
      rescue
        render_404
      end
    end

    # Only allow a list of trusted parameters through.
    def aplikasi_params
      params.require(:aplikasi).permit(:id_aplikasi, :kode, :nama_aplikasi, :deskripsi, :pemilik_proses, :default_version, :divisi, :status)
    end
end
