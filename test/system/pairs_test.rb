require "application_system_test_case"

class PairsTest < ApplicationSystemTestCase
  setup do
    @pair = pairs(:one)
  end

  test "visiting the index" do
    visit pairs_url
    assert_selector "h1", text: "Pairs"
  end

  test "creating a Pair" do
    visit pairs_url
    click_on "New Pair"

    fill_in "Play date", with: @pair.play_date
    fill_in "Player one", with: @pair.player_one_id
    fill_in "Player two", with: @pair.player_two_id
    click_on "Create Pair"

    assert_text "Pair was successfully created"
    click_on "Back"
  end

  test "updating a Pair" do
    visit pairs_url
    click_on "Edit", match: :first

    fill_in "Play date", with: @pair.play_date
    fill_in "Player one", with: @pair.player_one_id
    fill_in "Player two", with: @pair.player_two_id
    click_on "Update Pair"

    assert_text "Pair was successfully updated"
    click_on "Back"
  end

  test "destroying a Pair" do
    visit pairs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pair was successfully destroyed"
  end
end
