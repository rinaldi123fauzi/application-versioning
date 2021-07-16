json.set! :data do
  json.array! @aplikasis do |aplikasi|
    json.partial! 'aplikasis/aplikasi', aplikasi: aplikasi
    json.url  "
              #{link_to 'Show', aplikasi }
              #{link_to 'Edit', edit_aplikasi_path(aplikasi)}
              #{link_to 'Destroy', aplikasi, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end