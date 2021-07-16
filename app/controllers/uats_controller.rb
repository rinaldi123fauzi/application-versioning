class UatsController < ApplicationController
  before_action :set_uat, only: %i[ show edit update destroy ]
  load_and_authorize_resource
  respond_to :html, :json
  
  # GET /uats or /uats.json
  def index
    @uats = Uat.all
  end

  # GET /uats/1 or /uats/1.json
  def show
  end

  # GET /uats/new
  def new
    @uat = Uat.new

    @rfc = Rfc.find(params[:id])

    @no_uat = generate_docnum(@rfc.aplikasi.id_aplikasi)
  end

  # GET /uats/1/edit
  def edit
  end

  # POST /uats or /uats.json
  def create
    @uat = Uat.new(uat_params)

    unless params[:next_line].nil?
      @uat.status = "Closed"
    else
      @uat.status = "Open"
    end

    respond_to do |format|
      if @uat.save
        if params[:next_line]
          format.html { redirect_to "/changes/" + params[:uat][:id_rfc] + "/new_release", notice: "Uat was successfully created." }
          format.json { render :show, status: :created, location: @uat }
        else
          format.html { redirect_to rfc_path(params[:uat][:id_rfc]), notice: "Uat was successfully created." }
          format.json { render :show, status: :created, location: @uat }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @uat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uats/1 or /uats/1.json
  def update
    respond_to do |format|
      if @uat.update(uat_params)
        format.html { redirect_to @uat, notice: "Uat was successfully updated." }
        format.json { render :show, status: :ok, location: @uat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @uat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uats/1 or /uats/1.json
  def destroy
    @uat.destroy
    respond_to do |format|
      format.html { redirect_to uats_url, notice: "Uat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_uat
      @uat = Uat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def uat_params
      params.require(:uat).permit(:no_testing, :tgl_testing, :penguji, :id_rfc)
    end

    def generate_docnum(aplikasi)
      separator = "-"
      docnum = "UT" + separator + aplikasi
      rfc = Uat.where('no_testing LIKE ? and no_testing < ?', "#{docnum}%", "#{docnum + '98'}").last
      
      if rfc.present? and rfc.status == "Open"
        docnum = rfc.no_testing
        return docnum
      elsif rfc.present? and rfc.status == "Closed"
        split = rfc.no_testing.split('-')
        sequence_number = split[2]
        int_sequence_number = Integer(sequence_number, 10) + 1
        zero_length = 2 - rfc.no_testing[0..2].to_i

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
        docnum = "UT" + separator + aplikasi + separator + sequence_number
        return docnum
      end
    end
end
