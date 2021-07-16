json.set! :data do
  json.array! @api_tests do |api_test|
    json.partial! 'api_tests/api_test', api_test: api_test
    json.url  "
              #{link_to 'Show', api_test }
              #{link_to 'Edit', edit_api_test_path(api_test)}
              #{link_to 'Destroy', api_test, method: :delete, data: { confirm: 'Are you sure?' }}
              "
  end
end