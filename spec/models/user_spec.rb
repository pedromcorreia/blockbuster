require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }

  it 'is not valid without a email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with blank a email' do
    subject.email = ''
    expect(subject).to_not be_valid
  end

  it 'is not valid with wrong email' do
    subject.email = 'notvalid'
    expect(subject).to_not be_valid
  end

  it 'is valid valid attributes' do
    expect(subject).to be_valid
  end

  it 'should validate uniqueness of email' do
    user1 = create(:user)
    user = build(:user, email: user1.email)
    expect { user.save! }.to raise_error(
      ActiveRecord::RecordInvalid
    )
  end
end
