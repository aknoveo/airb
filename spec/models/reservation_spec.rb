require 'rails_helper'

RSpec.describe Reservation, type: :model do
  before :each do
    @user = FactoryBot.create(:user)
  end

  it "is not valid when end date is before a start date" do
    reservation = FactoryBot.build(:reservation, start_date: Date.today,
                                                 end_date: 2.days.ago, user: @user)
    expect(reservation).to_not be_valid
  end

  it "is valid when end date is after a start date" do
    reservation = FactoryBot.build(:reservation, start_date: Date.today,
                                                 end_date: 2.days.from_now, user: @user)
    expect(reservation).to be_valid
  end

  it "is not valid when same listing has reservations on overlapping dates" do
    listing = FactoryBot.create(:listing, user: @user)
    first_reservation = FactoryBot.create(:reservation, start_date: Date.today,
                                                        end_date: 2.days.from_now, listing: listing, user: @user)
    second_reservation = FactoryBot.build(:reservation, start_date: Date.today,
                                                        end_date: 2.days.from_now, listing: listing, user: @user)

    expect(first_reservation).to be_valid
    expect(listing.reload.reservations.size).to eq(1)
    expect(second_reservation).to_not be_valid
  end
end
