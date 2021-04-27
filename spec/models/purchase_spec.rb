require 'rails_helper'

RSpec.describe Purchase, type: :model do
  include ActiveSupport::Testing::TimeHelpers

  subject { create(:purchase) }

  it 'is not valid without a quality' do
    subject.quality = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with blank a quality' do
    subject.quality = ''
    expect(subject).to_not be_valid
  end

  it 'is not valid without a price' do
    subject.price = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid with blank a price' do
    subject.price = ''
    expect(subject).to_not be_valid
  end

  it 'is valid valid attributes' do
    expect(build(:purchase)).to be_valid
  end

  it 'is validate default value for price' do
    expect(subject.price).to match(299)
  end

  it 'should have a movie or episode' do
    purchase = build(:purchase, purchaseble: nil)
    expect { purchase.save! }.to raise_error(
      ActiveRecord::RecordInvalid
    )
  end

  it 'should not create two purchase for the same movie in the same day' do
    purchase = build(:purchase)
    purchase.save!
    expect { purchase.save! }.to raise_error(
      ActiveRecord::RecordInvalid
    )
  end

  it 'should not create two purchase for the same movie in 2 days' do
    purchase = build(:purchase)
    travel_to(2.days.ago)
    purchase.save!
    travel_back
    expect { purchase.save! }.to raise_error(
      ActiveRecord::RecordInvalid
    )
  end

  it 'should not create two purchase for the same movie in 3 days' do
    purchase = build(:purchase)
    travel_to(3.days.ago)
    purchase.save!
    expect(Purchase.count).to eq(1)
    travel_back
    purchase.save!
    expect(Purchase.count).to eq(1)
  end
end
