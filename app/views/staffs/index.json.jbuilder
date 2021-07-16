json.set! :data do
  json.array! @staffs do |staff|
    json.partial! 'staffs/staff', staff: staff
    json.url  "
              #{link_to 'Show', staff }
              #{link_to 'Edit', edit_staff_path(staff)}
              #{link_to 'Destroy', staff, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end