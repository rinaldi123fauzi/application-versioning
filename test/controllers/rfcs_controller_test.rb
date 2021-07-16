require 'test_helper'

class RfcsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rfc = rfcs(:one)
  end

  test "should get index" do
    get rfcs_url
    assert_response :success
  end

  test "should get new" do
    get new_rfc_url
    assert_response :success
  end

  test "should create rfc" do
    assert_difference('Rfc.count') do
      post rfcs_url, params: { rfc: { link: @rfc.link, no_registrasi_perubahan: @rfc.no_registrasi_perubahan, tanggal: @rfc.tanggal, uraian_perubahan: @rfc.uraian_perubahan, versi_aplikasi: @rfc.versi_aplikasi } }
    end

    assert_redirected_to rfc_url(Rfc.last)
  end

  test "should show rfc" do
    get rfc_url(@rfc)
    assert_response :success
  end

  test "should get edit" do
    get edit_rfc_url(@rfc)
    assert_response :success
  end

  test "should update rfc" do
    patch rfc_url(@rfc), params: { rfc: { link: @rfc.link, no_registrasi_perubahan: @rfc.no_registrasi_perubahan, tanggal: @rfc.tanggal, uraian_perubahan: @rfc.uraian_perubahan, versi_aplikasi: @rfc.versi_aplikasi } }
    assert_redirected_to rfc_url(@rfc)
  end

  test "should destroy rfc" do
    assert_difference('Rfc.count', -1) do
      delete rfc_url(@rfc)
    end

    assert_redirected_to rfcs_url
  end
end
