class ChangesController < ApplicationController
  before_action :set_change, only: %i[ show edit update destroy ]

  # GET /changes or /changes.json
  def index
    @changes = Change.all
  end

  # GET /changes/1 or /changes/1.json
  def show
  end

  # GET /changes/new
  def new
    @change = Change.new
    
    @getIdAplikasi = Rfc.find(params[:id])

    @get = Change.where(aplikasi_id: @getIdAplikasi.aplikasi_id).last
    if @get.present?
      @get1 = Uat.find_by_rfc_id(@get.rfc_id)
      @get2 = Uat.where('no_testing LIKE ?', "%#{@get1.no_testing}")
      @get3 = Change.where('no_testing LIKE ?', "%#{@get1.no_testing}")
    end
    
    if @get2.present? and @get2.count > 1
      if @get2.count != @get3.count
        @version_sourcecode = @get3.first.versi_sourcecode
      else
        @version_sourcecode = generate_versionapp_from_release(@getIdAplikasi.aplikasi_id)
      end
    else
      @version_sourcecode = generate_versionapp(@getIdAplikasi.aplikasi_id)
    end
  end

  # GET /changes/1/edit
  def edit
  end

  # POST /changes or /changes.json
  def create
    @change = Change.new(change_params)

    respond_to do |format|
      if @change.save
        format.html { redirect_to rfc_path(params[:change][:id_rfc]), notice: "Change was successfully created." }
        format.json { render :show, status: :created, location: @change }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @change.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /changes/1 or /changes/1.json
  def update
    respond_to do |format|
      if @change.update(change_params)
        format.html { redirect_to @change, notice: "Change was successfully updated." }
        format.json { render :show, status: :ok, location: @change }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @change.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /changes/1 or /changes/1.json
  def destroy
    @change.destroy
    respond_to do |format|
      format.html { redirect_to changes_url, notice: "Change was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_change
      begin
        @change = Change.find(params[:id])
      rescue
        render_404
      end
    end

    # Only allow a list of trusted parameters through.
    def change_params
      params.require(:change).permit(:tgl_release, :pemilik_proses, :versi_sourcecode, :id_rfc)
    end

    def generate_versionapp(id_aplikasi)
      separator = "."
      sequence_number = "00"
      @app = Aplikasi.find(id_aplikasi)

      rfc = Rfc.where(aplikasi_id: id_aplikasi).last

      a = rfc.versi_aplikasi.split('.')
      b = a[3]

      if rfc.present?
        if a[2] == "9"
          split = rfc.versi_aplikasi.split('.')
          sequence_number = split[1]
          int_sequence_number = Integer(sequence_number, 10) + 1
          zero_length = 1 - rfc.versi_aplikasi[0..1].to_i

          i = 0
          sequence_number = ""
          while i < zero_length  do
            if int_sequence_number.to_s <= "08"
              sequence_number = "0"
            end
            i +=1
          end
          major = sequence_number += int_sequence_number.to_s
          minor = "0"
          sequence_number = "00"
        end 

        if a[2] != "9" and b[2..3] >= "98"
          split = rfc.versi_aplikasi.split('.')
          sequence_number = split[2]
          int_sequence_number = Integer(sequence_number, 10) + 1
          zero_length = 1 - rfc.versi_aplikasi[0..1].to_i

          i = 0
          sequence_number = ""
          while i < zero_length  do
            if int_sequence_number.to_s <= "08"
              sequence_number = "0"
            end
            i +=1
          end
          major = split[1]
          minor = sequence_number += int_sequence_number.to_s
          sequence_number = "00"
        end 
        
        if b[2..3] <= "98"
          split = rfc.versi_aplikasi.split('.')
          sequence_number = split[3]
          getSequence = sequence_number[2..3]
          int_sequence_number = Integer(sequence_number[2..3], 10) + 1
          zero_length = 2 - rfc.versi_aplikasi[0..2].to_i

          i = 0
          sequence_number = ""
          while i < zero_length  do
            if getSequence <= "08"
              sequence_number = "0"
            end
            i +=1
          end
          major = split[1]
          minor = split[2]
          sequence_number += int_sequence_number.to_s
        end
      end
      docnum = "V" + separator + major + separator + minor + separator + @app.id_aplikasi + sequence_number
      return docnum
    end


    def generate_versionapp_from_release(id_aplikasi)
      separator = "."
      sequence_number = "00"
      @app = Aplikasi.find(id_aplikasi)

      rfc = Change.where(aplikasi_id: id_aplikasi).last

      a = rfc.versi_sourcecode.split('.')
      b = a[3]

      if rfc.present?
        if a[2] == "9"
          split = rfc.versi_sourcecode.split('.')
          sequence_number = split[1]
          int_sequence_number = Integer(sequence_number, 10) + 1
          zero_length = 1 - rfc.versi_sourcecode[0..1].to_i

          i = 0
          sequence_number = ""
          while i < zero_length  do
            if int_sequence_number.to_s <= "08"
              sequence_number = "0"
            end
            i +=1
          end
          major = sequence_number += int_sequence_number.to_s
          minor = "0"
          sequence_number = "00"
        end 

        if a[2] != "9" and b[2..3] >= "98"
          split = rfc.versi_sourcecode.split('.')
          sequence_number = split[2]
          int_sequence_number = Integer(sequence_number, 10) + 1
          zero_length = 1 - rfc.versi_sourcecode[0..1].to_i

          i = 0
          sequence_number = ""
          while i < zero_length  do
            if int_sequence_number.to_s <= "08"
              sequence_number = "0"
            end
            i +=1
          end
          major = split[1]
          minor = sequence_number += int_sequence_number.to_s
          sequence_number = "00"
        end 
        
        if b[2..3] <= "98"
          split = rfc.versi_sourcecode.split('.')
          sequence_number = split[3]
          getSequence = sequence_number[2..3]
          int_sequence_number = Integer(sequence_number[2..3], 10) + 1
          zero_length = 2 - rfc.versi_sourcecode[0..2].to_i

          i = 0
          sequence_number = ""
          while i < zero_length  do
            if getSequence <= "08"
              sequence_number = "0"
            end
            i +=1
          end
          major = split[1]
          minor = split[2]
          sequence_number += int_sequence_number.to_s
        end
      end
      docnum = "V" + separator + major + separator + minor + separator + @app.id_aplikasi + sequence_number
      return docnum
    end
end
