json.set! :data do
  json.array! @work_activities do |work_activity|
    json.partial! 'work_activities/work_activity', work_activity: work_activity
    json.url  "
              #{link_to 'Show', work_activity }
              #{link_to 'Edit', edit_work_activity_path(work_activity)}
              #{link_to 'Destroy', work_activity, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end