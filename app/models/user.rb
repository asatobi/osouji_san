# frozen_string_literal: true

class User < ApplicationRecord
  has_many :roles, dependent: :destroy
  has_many :cleaning_places, through: :roles

  enum gender: { male: 0, female: 1 }
  validates :name, presence: true, uniqueness: true, format: { with: /\A@[a-z]+\z/ }
  validates :gender, presence: true

  after_create :create_roles

  def create_roles
    if female?
      cleaning_places = CleaningPlace.where.not(id: CleaningPlace::MALE_TOILET_ID)
    elsif male?
      cleaning_places = CleaningPlace.where.not(id: CleaningPlace::FEMALE_TOILET_ID)
    end
    return unless cleaning_places.present?
    cleaning_places.each do |place|
      roles.create!(cleaning_place_id: place.id)
    end
  end
end
