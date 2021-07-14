require 'test_helper'

class PairsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @players = Player.all
    @player_one = @players[0]
    @player_two = @players[1]
    @pair = pairs(:one)
  end

  test "should get index" do
    get pairs_url
    assert_response :success
  end

  test "should get new" do
    get new_pair_url
    assert_response :success
  end

  test "should create pair" do
    assert_difference('Pair.count') do
      post pairs_url, params: { pair: { play_date: @pair.play_date, player_one_id: @player_one.id, player_two_id: @player_two.id } }
    end

    assert_redirected_to pair_url(Pair.last)
  end

  test "should show pair" do
    get pair_url(@pair)
    assert_response :success
  end

  test "should get edit" do
    get edit_pair_url(@pair)
    assert_response :success
  end

  test "should update pair" do
    patch pair_url(@pair), params: { pair: { play_date: @pair.play_date, player_one_id: @player_one.id, player_two_id: @player_two.id } }
    assert_redirected_to pair_url(@pair)
  end

  test "should destroy pair" do
    assert_difference('Pair.count', -1) do
      delete pair_url(@pair)
    end

    assert_redirected_to pairs_url
  end
end