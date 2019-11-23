# frozen_string_literal: true

class CleaningPlace < ApplicationRecord
  has_many :roles, dependent: :destroy
  has_many :users, through: :roles

  validates :name, presence: true

  after_create :create_roles

  FEMALE_TOILET_ID= CleaningPlace.where(name: 'トイレ(女性)').pluck(:id)
  MALE_TOILET_ID = CleaningPlace.where(name: ['トイレ(男性①)', 'トイレ(男性②)']).pluck(:id)
  WATERING_ID = CleaningPlace.find_by(name: '水やり').id

  def create_roles
    users = User.all
    if users.present?
      users.each do |user|
        role.create!(user_id: user.id)
      end
    end
  end
end
