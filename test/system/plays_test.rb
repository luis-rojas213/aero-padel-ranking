require "application_system_test_case"

class PlaysTest < ApplicationSystemTestCase
  setup do
    @play = plays(:one)
  end

  test "visiting the index" do
    visit plays_url
    assert_selector "h1", text: "Plays"
  end

  test "creating a Play" do
    visit plays_url
    click_on "New Play"

    fill_in "Pair one", with: @play.pair_one_id
    fill_in "Pair one point", with: @play.pair_one_point
    fill_in "Pair two", with: @play.pair_two_id
    fill_in "Pair two point", with: @play.pair_two_point
    fill_in "Play date", with: @play.play_date
    click_on "Create Play"

    assert_text "Play was successfully created"
    click_on "Back"
  end

  test "updating a Play" do
    visit plays_url
    click_on "Edit", match: :first

    fill_in "Pair one", with: @play.pair_one_id
    fill_in "Pair one point", with: @play.pair_one_point
    fill_in "Pair two", with: @play.pair_two_id
    fill_in "Pair two point", with: @play.pair_two_point
    fill_in "Play date", with: @play.play_date
    click_on "Update Play"

    assert_text "Play was successfully updated"
    click_on "Back"
  end

  test "destroying a Play" do
    visit plays_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Play was successfully destroyed"
  end
end
