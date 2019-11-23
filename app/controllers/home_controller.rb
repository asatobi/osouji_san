# frozen_string_literal: true

class HomeController < ApplicationController

  def index
    @user = User.new
    @users = User.all
    @cleaning_places = CleaningPlace.all
    @date = @cleaning_places[0].updated_at.strftime('%m月 %d日')
  end
end
