# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  color       :string           not null
#  birth_date  :date             not null
#  created_at  :datetime
#  updated_at  :datetime
#
require 'date'

class Cat < ActiveRecord::Base
  @valid_colors = ['Black', 'White', 'Gray', 'Purple']

  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: @valid_colors
  validates :sex, inclusion: ['M', 'F']

  has_many :cat_rental_requests

  
  def age
    (Date.today.jd- self.birth_date.jd)/365
  end

end
