require 'test_helper'

class PenyelesaiansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @penyelesaian = penyelesaians(:one)
  end

  test "should get index" do
    get penyelesaians_url
    assert_response :success
  end

  test "should get new" do
    get new_penyelesaian_url
    assert_response :success
  end

  test "should create penyelesaian" do
    assert_difference('Penyelesaian.count') do
      post penyelesaians_url, params: { penyelesaian: { durasi: @penyelesaian.durasi, kode_penyelesaian: @penyelesaian.kode_penyelesaian, pic: @penyelesaian.pic, tgl_selesai: @penyelesaian.tgl_selesai } }
    end

    assert_redirected_to penyelesaian_url(Penyelesaian.last)
  end

  test "should show penyelesaian" do
    get penyelesaian_url(@penyelesaian)
    assert_response :success
  end

  test "should get edit" do
    get edit_penyelesaian_url(@penyelesaian)
    assert_response :success
  end

  test "should update penyelesaian" do
    patch penyelesaian_url(@penyelesaian), params: { penyelesaian: { durasi: @penyelesaian.durasi, kode_penyelesaian: @penyelesaian.kode_penyelesaian, pic: @penyelesaian.pic, tgl_selesai: @penyelesaian.tgl_selesai } }
    assert_redirected_to penyelesaian_url(@penyelesaian)
  end

  test "should destroy penyelesaian" do
    assert_difference('Penyelesaian.count', -1) do
      delete penyelesaian_url(@penyelesaian)
    end

    assert_redirected_to penyelesaians_url
  end
end
