json.set! :data do
  json.array! @uats do |uat|
    json.partial! 'uats/uat', uat: uat
    json.url  "
              #{link_to 'Show', uat }
              #{link_to 'Edit', edit_uat_path(uat)}
              #{link_to 'Destroy', uat, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end