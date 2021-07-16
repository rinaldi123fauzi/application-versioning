module ApplicationHelper
    def setLogActivity(activity)
        AuditTrail.create!  user: current_user.username,
                            description: activity,
                            controller: controller_name,
                            action: action_name,
                            browser: request.env['HTTP_USER_AGENT'],
                            ip_address: request.env['REMOTE_ADDR']
    end

    def is_active_controller(controller_name)
        params[:controller] == controller_name ? "active" : nil
    end

    def is_active_action(action_name)
        params[:action] == action_name ? "active" : nil
    end

    def getRfcNumber(id)
        @getRfcNumber = Rfc.find(id)
        return @getRfcNumber.no_registrasi_perubahan
    end

    def render_404
        respond_to do |format|
          format.html { render template: 'pages/not_found_error', status: 404 }
          format.all { render nothing: true, status: 404 }
        end
      end
end
