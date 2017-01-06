class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods
  has_many :reservations, :through => :listings

  def city_openings(date1, date2)
    @notlistings = listings.joins(:reservations).where("reservations.checkin >= ? OR reservations.checkout <= ?", date2, date1)
    @lol = Listing.all.where.not(:id => @notlistings.pluck(:id))
  end

  def current_reservations
  end

  def self.highest_ratio_res_to_listings
    self.joins(:neighborhoods).joins(:listings).joins(:reservations).group(:listing_id).first
  end
end
