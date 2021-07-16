require 'test_helper'

class RisikosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @risiko = risikos(:one)
  end

  test "should get index" do
    get risikos_url
    assert_response :success
  end

  test "should get new" do
    get new_risiko_url
    assert_response :success
  end

  test "should create risiko" do
    assert_difference('Risiko.count') do
      post risikos_url, params: { risiko: { deskripsi: @risiko.deskripsi, nama: @risiko.nama } }
    end

    assert_redirected_to risiko_url(Risiko.last)
  end

  test "should show risiko" do
    get risiko_url(@risiko)
    assert_response :success
  end

  test "should get edit" do
    get edit_risiko_url(@risiko)
    assert_response :success
  end

  test "should update risiko" do
    patch risiko_url(@risiko), params: { risiko: { deskripsi: @risiko.deskripsi, nama: @risiko.nama } }
    assert_redirected_to risiko_url(@risiko)
  end

  test "should destroy risiko" do
    assert_difference('Risiko.count', -1) do
      delete risiko_url(@risiko)
    end

    assert_redirected_to risikos_url
  end
end
