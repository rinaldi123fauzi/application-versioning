require 'test_helper'

class AplikasisControllerTest < ActionDispatch::IntegrationTest
  setup do
    @aplikasi = aplikasis(:one)
  end

  test "should get index" do
    get aplikasis_url
    assert_response :success
  end

  test "should get new" do
    get new_aplikasi_url
    assert_response :success
  end

  test "should create aplikasi" do
    assert_difference('Aplikasi.count') do
      post aplikasis_url, params: { aplikasi: { deskripsi: @aplikasi.deskripsi, id_aplikasi: @aplikasi.id_aplikasi, kode: @aplikasi.kode, nama_aplikasi: @aplikasi.nama_aplikasi, pemilik_proses: @aplikasi.pemilik_proses } }
    end

    assert_redirected_to aplikasi_url(Aplikasi.last)
  end

  test "should show aplikasi" do
    get aplikasi_url(@aplikasi)
    assert_response :success
  end

  test "should get edit" do
    get edit_aplikasi_url(@aplikasi)
    assert_response :success
  end

  test "should update aplikasi" do
    patch aplikasi_url(@aplikasi), params: { aplikasi: { deskripsi: @aplikasi.deskripsi, id_aplikasi: @aplikasi.id_aplikasi, kode: @aplikasi.kode, nama_aplikasi: @aplikasi.nama_aplikasi, pemilik_proses: @aplikasi.pemilik_proses } }
    assert_redirected_to aplikasi_url(@aplikasi)
  end

  test "should destroy aplikasi" do
    assert_difference('Aplikasi.count', -1) do
      delete aplikasi_url(@aplikasi)
    end

    assert_redirected_to aplikasis_url
  end
end
