json.set! :data do
  json.array! @risikos do |risiko|
    json.partial! 'risikos/risiko', risiko: risiko
    json.url  "
              #{link_to 'Show', risiko }
              #{link_to 'Edit', edit_risiko_path(risiko)}
              #{link_to 'Destroy', risiko, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end