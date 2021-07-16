module Api
    module V1
      class ApiTestsController < ApplicationController
        skip_before_action :verify_authenticity_token
        skip_before_action :authenticate_user!
        before_action :has_valid_api_key!
        def index
          api_tests = ApiTest.order('created_at DESC');
          render json: api_tests, status: :ok
        end
        def show
          api_tests = ApiTest.find(params[:id])
          render json: api_tests, status: :ok
        end
        def create
          @api_tests = ApiTest.new(api_test_params)
          if @api_tests.save
            render json: {status: 'SUCCESSFULLY', message:'saved units', data:@api_tests}, status: :ok
          else
            render json: {status: 'Error', message:'Units is not saved', data:@api_tests.errors}, status: :unprocessable_entity
          end
        end
        def update
          api_tests = ApiTest.find(params[:id])
          if api_tests.update_attributes(api_test_params)
            render json: {status: 'SUCCESSFULLY', message:'Unit is update', data:api_tests}, status: :ok
          else
            render json: {status: 'Error', message:'Unit is not update', data:api_tests.errors}, status: :unprocessable_entity
          end
        end
        def destroy
          api_tests = ApiTest.find(params[:id])
          api_tests.destroy!
          render json: {status: 'SUCCESSFULLY', message:'Some field has been Deleted', data:api_tests}, status: :ok
        end
  
        private
        def api_test_params
          params.require(:api_test).permit(:nama, :alamat)
        end
        def has_valid_api_key?
          request.headers['X-Api-Key'] == 'Pg4550Lut1oN!'
        end
        def has_valid_api_key!
          return head :forbidden unless has_valid_api_key?
        end
      end
    end
  end
  