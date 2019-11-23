# frozen_string_literal: true

class CleaningPlacesController < ApplicationController
  before_action :clear_person_in_charge, only: :shuffle

  def index
    if params[:id]
      set_cleaning_place
    end
    @cleaning_places = CleaningPlace.all
  end

  def create
    cleaning_place = CleaningPlace.new(params_cleaning_place)
    begin
      cleaning_place.save!
      redirect_to request.referer, notice: "掃除場所に#{cleaning_place.name}を追加しました"
    rescue StandardError => e
      logger.debug e.message
      redirect_to request.referer, alert: cleaning_place.errors.full_messages
    end
  end

  def update
    cleaning_place = CleaningPlace.find(params[:id])
    cleaning_place.update(params_cleaning_place)
    redirect_to action: :index
  end

  def shuffle
    users = User.where(id: params['user']).to_a
    cleaning_places = CleaningPlace.all.shuffle
    if cleaning_places.count > users.count
      cleaning_places = CleaningPlace.where.not(id: CleaningPlace::WATERING_ID).shuffle
    end
    begin
      cleaning_places.each do |place|
        break if users.empty?

        role = Role.where(cleaning_place_id: place.id, user_id: users.pluck(:id)).order(:count).first
        place.person_in_charge = role.user.name
        place.save!
        users.delete_if { |user| user.id == role.user_id }
      end
    rescue StandardError => e
      logger.debug e.message
      logger.debug 'もう一度シャッフル!'
      redirect_to shuffle_cleaning_places_path('user' => params['user'])
    else
      redirect_to :root
    end
  end

  # TODO: mattermostへの送信部分未実装
  def send_to_matermost
    increment_counter
    redirect_to :root, notice: '送信しました'
  end

  def destroy
    cleaning_place = CleaningPlace.find(params[:id])
    cleaning_place.destroy!
    redirect_to request.referer, notice: "#{cleaning_place.name}を削除しました"
  end

  private

  def set_cleaning_place
    @cleaning_place = CleaningPlace.find(params[:id])
  end

  def clear_person_in_charge
    CleaningPlace.update_all(person_in_charge: nil)
  end

  def params_cleaning_place
    params.require(:cleaning_place).permit(:name)
  end

  def increment_counter
    cleaning_places_for_today = CleaningPlace.where.not(person_in_charge: nil)
    cleaning_places_for_today.each do |place|
      user = User.find_by(name: place.person_in_charge)
      place.roles.find_by(user_id: user.id).increment!(:count)
    end
  end
end
