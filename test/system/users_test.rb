# frozen_string_literal: true

require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  setup do
    @user = users(:one)
  end

  test 'visiting the index' do
    visit users_url
    assert_selector 'h1', text: 'Users'
  end

  test 'should create user' do
    visit users_url
    click_on 'New user'

    fill_in 'Bio', with: @user.Bio
    fill_in 'Photo', with: @user.Photo
    fill_in 'Postcounter', with: @user.PostCounter
    fill_in 'Name', with: @user.name
    click_on 'Create User'

    assert_text 'User was successfully created'
    click_on 'Back'
  end

  test 'should update User' do
    visit user_url(@user)
    click_on 'Edit this user', match: :first

    fill_in 'Bio', with: @user.Bio
    fill_in 'Photo', with: @user.Photo
    fill_in 'Postcounter', with: @user.PostCounter
    fill_in 'Name', with: @user.name
    click_on 'Update User'

    assert_text 'User was successfully updated'
    click_on 'Back'
  end

  test 'should destroy User' do
    visit user_url(@user)
    click_on 'Destroy this user', match: :first

    assert_text 'User was successfully destroyed'
  end
end
