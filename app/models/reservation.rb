class Reservation < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  validates :start_date, :end_date, presence: true

  validate :reservations_cannot_overlap
  validate :end_date_after_start_date

  def reservations_cannot_overlap
    return if listing.reservations.blank?

    overlap = listing.reservations.except(self).any? do |r|
      (r.start_date..r.end_date).overlaps?(start_date..end_date)
    end

    errors.add(:reservation, 'already booked on these dates') if overlap
  end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "end date should be after start date")
    end
  end
end
