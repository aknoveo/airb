require 'rails_helper'

RSpec.describe Listing, type: :model do
  before :each do
    @user = FactoryBot.create(:user)
  end

  it "is not valid without a name" do
    listing = FactoryBot.build(:listing, name: nil)
    expect(listing).to_not be_valid
  end

  it "shows listings that are available" do
    search_params = {
      start_date: 2.weeks.from_now,
      end_date: 3.weeks.from_now,
    }

    listing = FactoryBot.create(:listing)
    FactoryBot.create(:reservation, start_date: Date.today, end_date: 1.week.from_now, user: @user, listing: listing)

    expect(Listing.search(search_params).count).to eq(1)
  end

  it "doesn't show listings that are alredy booked" do
    search_params = {
      start_date: Date.today,
      end_date: 1.weeks.from_now,
    }

    listing = FactoryBot.create(:listing)
    FactoryBot.create(:reservation, start_date: Date.today, end_date: 1.week.from_now, user: @user, listing: listing)

    expect(Listing.search(search_params).count).to eq(0)
  end
end
