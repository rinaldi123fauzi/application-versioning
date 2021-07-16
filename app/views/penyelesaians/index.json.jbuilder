json.set! :data do
  json.array! @penyelesaians do |penyelesaian|
    json.partial! 'penyelesaians/penyelesaian', penyelesaian: penyelesaian
    json.url  "
              #{link_to 'Show', penyelesaian }
              #{link_to 'Edit', edit_penyelesaian_path(penyelesaian)}
              #{link_to 'Destroy', penyelesaian, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end