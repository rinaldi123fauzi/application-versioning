class PenyelesaiansController < ApplicationController
  before_action :set_penyelesaian, only: %i[ show edit update destroy ]
  load_and_authorize_resource
  respond_to :html, :json
  
  # GET /penyelesaians or /penyelesaians.json
  def index
    @penyelesaians = Penyelesaian.all
  end

  # GET /penyelesaians/1 or /penyelesaians/1.json
  def show
  end

  # GET /penyelesaians/new
  def new
    @penyelesaian = Penyelesaian.new
    
    @rfc = Rfc.find(params[:id])

    @no_penyelesaian = generate_docnum(@rfc.aplikasi.id_aplikasi)
  end

  # GET /penyelesaians/1/edit
  def edit
  end

  # POST /penyelesaians or /penyelesaians.json
  def create
    @penyelesaian = Penyelesaian.new(penyelesaian_params)

    unless params[:next_line].nil?
      @penyelesaian.status = "Closed"
    else
      @penyelesaian.status = "Open"
    end

    respond_to do |format|
      if @penyelesaian.save
        if params[:next_line]
          format.html { redirect_to "/internals/" + params[:penyelesaian][:id_rfc] + "/new_internal", notice: "Penyelesaian was successfully created." }
          format.json { render :show, status: :created, location: @penyelesaian }
        else
          format.html { redirect_to rfc_path(params[:penyelesaian][:id_rfc]), notice: "Penyelesaian was successfully created." }
          format.json { render :show, status: :created, location: @penyelesaian }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @penyelesaian.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /penyelesaians/1 or /penyelesaians/1.json
  def update
    respond_to do |format|
      if @penyelesaian.update(penyelesaian_params)
        format.html { redirect_to @penyelesaian, notice: "Penyelesaian was successfully updated." }
        format.json { render :show, status: :ok, location: @penyelesaian }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @penyelesaian.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /penyelesaians/1 or /penyelesaians/1.json
  def destroy
    @penyelesaian.destroy
    respond_to do |format|
      format.html { redirect_to penyelesaians_url, notice: "Penyelesaian was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_penyelesaian
      begin
        @penyelesaian = Penyelesaian.find(params[:id])
      rescue
        render_404
      end
    end

    # Only allow a list of trusted parameters through.
    def penyelesaian_params
      params.require(:penyelesaian).permit(:kode_penyelesaian, :tgl_selesai, :durasi, :pic, :id_rfc)
    end

    def generate_docnum(aplikasi)
      separator = "-"
      docnum = "PP" + separator + aplikasi
      rfc = Penyelesaian.where('kode_penyelesaian LIKE ? and kode_penyelesaian < ?', "#{docnum}%", "#{docnum + '98'}").last
      
      if rfc.present? and rfc.status == "Open"
        docnum = rfc.kode_penyelesaian
        return docnum
      elsif rfc.present? and rfc.status == "Closed"
        split = rfc.kode_penyelesaian.split('-')
        sequence_number = split[2]
        int_sequence_number = Integer(sequence_number, 10) + 1
        zero_length = 2 - rfc.kode_penyelesaian[0..2].to_i

        i = 0
        sequence_number = ""
        while i < zero_length  do
          sequence_number1 = split[2]
          if sequence_number1 <= "08"
            sequence_number = "0"
          end
          i +=1
        end
        sequence_number += int_sequence_number.to_s

        docnum = docnum + separator + sequence_number
        return docnum
      else
        sequence_number = "00"
        docnum = "PP" + separator + aplikasi + separator + sequence_number
        return docnum
      end
      
    end
end
