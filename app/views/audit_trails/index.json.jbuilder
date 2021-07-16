json.set! :data do
  json.array! @audit_trails do |audit_trail|
    json.partial! 'audit_trails/audit_trail', audit_trail: audit_trail
    json.url  "
              #{link_to 'Show', audit_trail }
              #{link_to 'Edit', edit_audit_trail_path(audit_trail)}
              #{link_to 'Destroy', audit_trail, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end