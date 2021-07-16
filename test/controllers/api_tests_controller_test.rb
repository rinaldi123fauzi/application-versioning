require 'test_helper'

class ApiTestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_test = api_tests(:one)
  end

  test "should get index" do
    get api_tests_url
    assert_response :success
  end

  test "should get new" do
    get new_api_test_url
    assert_response :success
  end

  test "should create api_test" do
    assert_difference('ApiTest.count') do
      post api_tests_url, params: { api_test: { alamat: @api_test.alamat, nama: @api_test.nama } }
    end

    assert_redirected_to api_test_url(ApiTest.last)
  end

  test "should show api_test" do
    get api_test_url(@api_test)
    assert_response :success
  end

  test "should get edit" do
    get edit_api_test_url(@api_test)
    assert_response :success
  end

  test "should update api_test" do
    patch api_test_url(@api_test), params: { api_test: { alamat: @api_test.alamat, nama: @api_test.nama } }
    assert_redirected_to api_test_url(@api_test)
  end

  test "should destroy api_test" do
    assert_difference('ApiTest.count', -1) do
      delete api_test_url(@api_test)
    end

    assert_redirected_to api_tests_url
  end
end
