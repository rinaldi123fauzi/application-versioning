module Api
    module V1
      class VersionImsController < ApplicationController
        skip_before_action :verify_authenticity_token
        skip_before_action :authenticate_user!
        before_action :has_valid_api_key!
        def index
          version = Change.where(aplikasi_id: 17).order(:versi_sourcecode => :asc).last
          render json: {status: 'SUCCESSFULLY', message:'loaded version', data:version.versi_sourcecode}, status: :ok
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
  