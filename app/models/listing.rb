class Listing < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy

  has_one_attached :image do |attachable|
    attachable.variant :small, resize_to_limit: [200, 200]
    attachable.variant :medium, resize_to_limit: [500, 500]
  end

  def free_on?(book_start, book_end)
    !reservations.any? do |_r|
      (book_start..book_end).overlaps?(start_date..end_date)
    end
  end

  # rubocop:disable Metrics/MethodLength
  def self.search(params)
    return Listing.all if params.blank?

    start_date = params[:start_date].to_date || Date.today
    end_date = params[:end_date].to_date || 2.years.from_now
    guests = params[:guests].to_i
    city = params[:city].to_s

    joins("LEFT OUTER JOIN reservations
           ON reservations.listing_id=listings.id
           AND ((reservations.start_date, reservations.end_date)
           OVERLAPS ('#{start_date}', '#{end_date}'))")
      .where('(NOT ((reservations.start_date, reservations.end_date)
             OVERLAPS (?, ?))
             OR (reservations.start_date IS NULL OR reservations.end_date IS NULL))
             AND listings.guests >= ?
             AND lower(listings.city) like ?', start_date, end_date, guests, "%#{city}%")
  end
  # rubocop:enable Metrics/MethodLength
end
