class ApiTestsController < ApplicationController
  before_action :set_api_test, only: %i[ show edit update destroy ]

  # GET /api_tests or /api_tests.json
  def index
    @api_tests = ApiTest.all
  end

  # GET /api_tests/1 or /api_tests/1.json
  def show
  end

  # GET /api_tests/new
  def new
    @api_test = ApiTest.new
  end

  # GET /api_tests/1/edit
  def edit
  end

  # POST /api_tests or /api_tests.json
  def create
    @api_test = ApiTest.new(api_test_params)

    respond_to do |format|
      if @api_test.save
        format.html { redirect_to @api_test, notice: "Api test was successfully created." }
        format.json { render :show, status: :created, location: @api_test }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @api_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api_tests/1 or /api_tests/1.json
  def update
    respond_to do |format|
      if @api_test.update(api_test_params)
        format.html { redirect_to @api_test, notice: "Api test was successfully updated." }
        format.json { render :show, status: :ok, location: @api_test }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @api_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api_tests/1 or /api_tests/1.json
  def destroy
    @api_test.destroy
    respond_to do |format|
      format.html { redirect_to api_tests_url, notice: "Api test was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_test
      @api_test = ApiTest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_test_params
      params.require(:api_test).permit(:nama, :alamat)
    end
end
