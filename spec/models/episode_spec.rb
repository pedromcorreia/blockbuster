# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Episode, type: :model do
  subject { create(:episode) }

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

  it 'should validate uniqueness of title' do
    episode1 = create(:episode)
    episode = build(:episode, title: episode1.title)
    expect { episode.save! }.to raise_error(
      ActiveRecord::RecordInvalid
    )
  end
end
