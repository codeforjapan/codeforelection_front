require 'test_helper'

class SenkyokusControllerTest < ActionDispatch::IntegrationTest
  setup do
    @senkyoku = senkyokus(:one)
  end

  test "should get index" do
    get senkyokus_url
    assert_response :success
  end

  test "should get new" do
    get new_senkyoku_url
    assert_response :success
  end

  test "should create senkyoku" do
    assert_difference('Senkyoku.count') do
      post senkyokus_url, params: { senkyoku: { pref_code: @senkyoku.pref_code, senkyoku_no: @senkyoku.senkyoku_no, zip_code: @senkyoku.zip_code } }
    end

    assert_redirected_to senkyoku_url(Senkyoku.last)
  end

  test "should show senkyoku" do
    get senkyoku_url(@senkyoku)
    assert_response :success
  end

  test "should get edit" do
    get edit_senkyoku_url(@senkyoku)
    assert_response :success
  end

  test "should update senkyoku" do
    patch senkyoku_url(@senkyoku), params: { senkyoku: { pref_code: @senkyoku.pref_code, senkyoku_no: @senkyoku.senkyoku_no, zip_code: @senkyoku.zip_code } }
    assert_redirected_to senkyoku_url(@senkyoku)
  end

  test "should destroy senkyoku" do
    assert_difference('Senkyoku.count', -1) do
      delete senkyoku_url(@senkyoku)
    end

    assert_redirected_to senkyokus_url
  end
end
