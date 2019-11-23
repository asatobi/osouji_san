# frozen_string_literal: true

class CleaningPlacesController < ApplicationController
  before_action :clear_person

  def shuffle
    users = User.where(id: params['user']).to_a
    cleaning_places = CleaningPlace.all.shuffle
    begin
      cleaning_places.each do |place|
        break if users.empty?
        role = Role.where(cleaning_place_id: place.id, user_id: users.pluck(:id)).order(:count).first
        place.person = role.user.name
        place.save!
        users.delete_if { |user| user.id == role.user_id }
      end
    rescue StandardError
      logger.debug 'もう一回'
      redirect_to cleaning_places_shuffle_path('user' => params['user'])
    else
      cleaning_places_for_today = CleaningPlace.where.not(person: nil)
      cleaning_places_for_today.each do |place|
        user = User.find_by(name: place.person)
        place.roles.find_by(user_id: user.id).increment!(:count)
      end
      redirect_to :root
    end
  end

  def clear_person
    CleaningPlace.update_all(person: nil)
  end
end
