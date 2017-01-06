class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validates :rating, presence: true
  validates :description, presence: true
  validates :reservation, presence: true
  validate :reservation_val, if: [:reservation]


  #review invalid without reservation that has been
  #accepted and checkedout
  private
  def reservation_val
    if reservation.checkout > Date.today || reservation.status == "pending"
      errors.add(:reservation, "The reservation is not over or approved")
    end
  end
end
