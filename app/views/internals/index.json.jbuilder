json.set! :data do
  json.array! @internals do |internal|
    json.partial! 'internals/internal', internal: internal
    json.url  "
              #{link_to 'Show', internal }
              #{link_to 'Edit', edit_internal_path(internal)}
              #{link_to 'Destroy', internal, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end