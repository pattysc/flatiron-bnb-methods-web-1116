class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, presence: true
  validates :checkout, presence: true

  validate :own_listing
  validate :availability

  def own_listing
    if guest_id == listing.host_id
      errors.add(:guest_id, "unvalid guest")
    end
  end


  def availability
    @checkin = checkin
    @checkout = checkout

    if !Reservation.all.empty? && id.nil?
      @res = Reservation.where("checkin >= ? OR checkout <= ?", @checkout, @checkin)
      if @res
        errors.add(:lol, "checkin not available in this date")
      end
    end
  end

end
