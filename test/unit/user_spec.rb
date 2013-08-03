require_relative 'spec_helper'

describe User do

  before do
    User.delete_all
  end

  it 'create and authenticate user' do
    user = User.create_user 'Max Mustermann', 'max.mustermann@example.com', 'secret'
    user.wont_be_nil

    authenticated_user = User.authenticate 'max.mustermann@example.com', 'secret'
    authenticated_user.wont_be_nil
    authenticated_user.name.must_equal 'Max Mustermann'
  end

  it 'find non existing user' do
    non_user = User.find_by_email 'nonexisting'
    non_user.must_be_nil
  end

end