require 'test_helper'

class ImportRfcControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get import_rfc_create_url
    assert_response :success
  end

  test "should get update" do
    get import_rfc_update_url
    assert_response :success
  end

  test "should get destroy" do
    get import_rfc_destroy_url
    assert_response :success
  end

end
