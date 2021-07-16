class WorkActivitiesController < ApplicationController
  before_action :set_work_activity, only: %i[ show edit update destroy ]

  # GET /work_activities or /work_activities.json
  def index
    if params[:staff].present? and params[:tahun].present?
      @work_activities = WorkActivity.where('staff_id = ? and tahun = ?', params[:staff], params[:tahun]).order(:periode_waktu => :desc)
      @countActivities = WorkActivity.order(:periode_waktu => :desc).count
      @result = WorkActivity.where('staff_id = ? and tahun = ?', params[:staff], params[:tahun]).order(:periode_waktu => :desc).count
    else
      @work_activities = WorkActivity.order(:periode_waktu => :desc).limit(10)
      @countActivities = WorkActivity.order(:periode_waktu => :desc).count
      @result = 10
    end
  end

  # GET /work_activities/1 or /work_activities/1.json
  def show
    @work_activity = WorkActivity.find(params[:id])
    @aktivitas =  if (@work_activity.aktivitas.nil? or @work_activity.aktivitas.empty?) then
                    ""
                  else
                    @work_activity.aktivitas[0, 1] == "[" ? JSON::parse(@work_activity.aktivitas) : ""
                  end
  end

  # GET /work_activities/new
  def new
    @work_activity = WorkActivity.new
  end

  # GET /work_activities/1/edit
  def edit
    @work_activity = WorkActivity.find(params[:id])
    @aktivitas =  if (@work_activity.aktivitas.nil? or @work_activity.aktivitas.empty?) then
                    ""
                  else
                    @work_activity.aktivitas[0, 1] == "[" ? JSON::parse(@work_activity.aktivitas) : ""
                  end
  end

  # POST /work_activities or /work_activities.json
  def create
    @work_activity = WorkActivity.new(work_activity_params)
    unless params[:aktivitas].nil?
      @array = []
      @array = params[:aktivitas]
      @work_activity.aktivitas = @array
    end

    respond_to do |format|
      if @work_activity.save
        if params[:next_line]
          format.html { redirect_back(fallback_location: root_path, notice: "Form Aktivitas telah dibuat.") }
          format.json { render :show, status: :created, location: @main_responsibility }
        else
          format.html { redirect_to @work_activity, notice: "Form Aktivitas telah dibuat." }
          format.json { render :show, status: :created, location: @work_activity }
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @work_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /work_activities/1 or /work_activities/1.json
  def update
    respond_to do |format|
      if @work_activity.update(work_activity_params)
        unless params[:aktivitas].nil?
          @array = []
          @array = params[:aktivitas]
          @work_activity.update(aktivitas: @array)
        end
        @tahun = @work_activity.periode_waktu.strftime("%Y")
        @bulan = @work_activity.periode_waktu.strftime("%m")

        @work_activity.update(issued_by: current_user.username)
        @work_activity.update(tahun: @tahun)
        @work_activity.update(bulan: @bulan)

        format.html { redirect_to @work_activity, notice: "Work activity was successfully updated." }
        format.json { render :show, status: :ok, location: @work_activity }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @work_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_activities/1 or /work_activities/1.json
  def destroy
    @getActivities = WorkActivity.find(params[:id])
    @arrayData = []
    @arrayData = {
        'Nama : ' => @getActivities.staff.try(:nama),
        'Periode Waktu : ' => @getActivities.try(:periode_waktu),
        'Aktivitas : ' => @getActivities.try(:aktivitas),
        'Waktu Aktivitas : ' => @getActivities.try(:waktu_per_aktivitas),
        'Tahun : ' => @getActivities.try(:tahun),
        'Issued : ' => @getActivities.try(:issued_by)
    }
    setLogActivity("Menghapus data : " + @arrayData.to_s)
    @work_activity.destroy
    respond_to do |format|
      format.html { redirect_to work_activities_url, notice: "Work activity was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def delete_file
    @getStaff = WorkActivity.find(params[:work_activity_id])
    @attachment = ActiveStorage::Attachment.find(params[:attachment_id])
    setLogActivity("Menghapus lampiran : " + @attachment.filename.to_s + " a/n " + @getStaff.staff.nama)
    @attachment.purge # or use purge_later
    redirect_back(fallback_location: request.referer)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_activity
      @work_activity = WorkActivity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def work_activity_params
      params.require(:work_activity).permit(:staff_id, :periode_waktu, :aktivitas, :waktu_per_aktivitas, :tahun, :bulan, :issued_by, :nama_pembuat, lampiran: [])
    end
end
