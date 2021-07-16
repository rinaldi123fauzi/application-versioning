json.extract! audit_trail, :id, :user, :description, :controller, :action, :browser, :ip_address, :created_at, :updated_at
json.url audit_trail_url(audit_trail, format: :json)
