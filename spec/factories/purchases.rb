FactoryBot.define do
  factory :purchase do
    quality { 'hd' }
    price { 1 }
    purchaseble { create(:movie) }
    user { create(:user) }
  end
end
