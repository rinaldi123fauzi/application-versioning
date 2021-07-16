json.set! :data do
  json.array! @rfcs do |rfc|
    json.partial! 'rfcs/rfc', rfc: rfc
    json.url  "
              #{link_to 'Show', rfc }
              #{link_to 'Edit', edit_rfc_path(rfc)}
              #{link_to 'Destroy', rfc, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end