json.set! :data do
  json.array! @priorities do |priority|
    json.partial! 'priorities/priority', priority: priority
    json.url  "
              #{link_to 'Show', priority }
              #{link_to 'Edit', edit_priority_path(priority)}
              #{link_to 'Destroy', priority, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end