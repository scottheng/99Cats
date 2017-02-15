# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: ['PENDING', 'APPROVED', 'DENIED']
  validate :conflicting_date
  belongs_to :cat, dependent: :destroy

  def conflicting_date
    propsed_rental_period = (self.start_date.jd..self.end_date.jd).to_a
    approved_rentals = self.overlapping_approved_requests
    approved_rentals.each do |rental|
      if propsed_rental_period.include?(rental.start_date.jd) || propsed_rental_period.include?(rental.end_date.jd)
        errors[:cat_id] << 'Conflicting dates'
      end
    end
  end

  def conflict?
    propsed_rental_period = (self.start_date.jd..self.end_date.jd).to_a
    approved_rentals = self.overlapping_approved_requests
    approved_rentals.each do |rental|
      if propsed_rental_period.include?(rental.start_date.jd) || propsed_rental_period.include?(rental.end_date.jd)
        errors[:cat_id] << 'Conflicting dates'
      end
    end
  end

  def overlapping_requests
    self.cat.cat_rental_requests.where.not(id: self.id)
  end

  def overlapping_approved_requests
    self.overlapping_requests.where(status: "APPROVED")
  end

  def overlapping_pending_requests
    self.overlapping_requests.where(status: "PENDING")
  end

  def approve!
    CatRentalRequest.transaction do
      self.status = 'APPROVED'
      rental_period = (self.start_date.jd..self.end_date.jd).to_a
      self.overlapping_pending_requests.each do |pending|
        if rental_period.include?(pending.start_date.jd) || rental_period.include?(pending.end_date.jd)
          pending.deny!
        end
      end

      self.save
    end
  end

  def deny!
    CatRentalRequest.transaction do
      self.status = 'DENIED'
      self.save
    end
  end
end
