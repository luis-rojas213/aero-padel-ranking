require 'test_helper'

class PlaysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pairs = Pair.all
    @pair_one = @pairs[0]
    @pair_two = @pairs[1]
    @play = plays(:one)
  end

  test "should get index" do
    get plays_url
    assert_response :success
  end

  test "should get new" do
    get new_play_url
    assert_response :success
  end

  test "should create play" do
    assert_difference('Play.count') do
      post plays_url, params: { play: { pair_one_id: @pair_one.id, pair_one_point: @play.pair_one_point, pair_two_id: @pair_two.id, pair_two_point: @play.pair_two_point, play_date: @play.play_date } }
    end

    assert_redirected_to play_url(Play.last)
  end

  test "should show play" do
    get play_url(@play)
    assert_response :success
  end

  test "should get edit" do
    get edit_play_url(@play)
    assert_response :success
  end

  test "should update play" do
    patch play_url(@play), params: { play: { pair_one_id: @pair_one.id, pair_one_point: @play.pair_one_point, pair_two_id: @pair_two.id, pair_two_point: @play.pair_two_point, play_date: @play.play_date } }
    assert_redirected_to play_url(@play)
  end

  test "should destroy play" do
    assert_difference('Play.count', -1) do
      delete play_url(@play)
    end

    assert_redirected_to plays_url
  end
end
