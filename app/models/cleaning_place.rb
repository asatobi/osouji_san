# frozen_string_literal: true

class CleaningPlace < ApplicationRecord
  has_many :roles, dependent: :destroy
  has_many :users, through: :roles

  validates :name, presence: true

  after_create :create_roles

  scope :order_name, -> { order('name COLLATE "C" ASC') }

  FEMALE_TOILET_ID = 1
  MALE_TOILET_ID = [2, 3].freeze
  WATERING_ID = 13

  def create_roles
    users = User.all
    return unless users.present?

    users.each do |user|
      roles.create!(user_id: user.id)
    end
  end
end
