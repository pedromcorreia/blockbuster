require 'rails_helper'

RSpec.describe Movie, type: :model do
  subject { create(:movie) }

  it 'is not valid without a title' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with blank a title' do
    subject.title = ''
    expect(subject).to_not be_valid
  end

  it 'is not valid without a plot' do
    subject.plot = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with blank a title' do
    subject.plot = ''
    expect(subject).to_not be_valid
  end

  it 'is valid valid attributes' do
    expect(subject).to be_valid
  end
end