class Reservation < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  validates :start_date, :end_date, presence: true

  validate :reservations_cannot_overlap

  def reservations_cannot_overlap
    return if listing.reservations.blank?

    overlap = listing.reservations.except(self).any? do |r|
      (r.start_date..r.end_date).overlaps?(start_date..end_date)
    end

    errors.add(:reservation, 'already booked on these dates') if overlap
  end
end
