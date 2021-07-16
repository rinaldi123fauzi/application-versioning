json.set! :data do
  json.array! @changes do |change|
    json.partial! 'changes/change', change: change
    json.url  "
              #{link_to 'Show', change }
              #{link_to 'Edit', edit_change_path(change)}
              #{link_to 'Destroy', change, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end