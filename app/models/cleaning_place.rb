# frozen_string_literal: true

class CleaningPlace < ApplicationRecord
  has_many :roles, dependent: :destroy
  has_many :users, through: :roles

  validates :name, presence: true

  after_create :create_roles

  FEMALE_TOILET_ID = 1
  MALE_TOILET_ID = [2]


  def create_roles
    users = User.all
    if users.present?
      users.each do |user|
        role.create!(user_id: user.id)
      end
    end
  end
end
