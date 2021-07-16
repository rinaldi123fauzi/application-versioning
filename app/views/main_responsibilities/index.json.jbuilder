json.set! :data do
  json.array! @main_responsibilities do |main_responsibility|
    json.partial! 'main_responsibilities/main_responsibility', main_responsibility: main_responsibility
    json.url  "
              #{link_to 'Show', main_responsibility }
              #{link_to 'Edit', edit_main_responsibility_path(main_responsibility)}
              #{link_to 'Destroy', main_responsibility, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end