# encoding: utf-8
require_relative 'spec_helper'

describe 'Home page' do

  it 'Open the home page' do
    visit '/'
    must_have_content 'Singular'
  end

end
