# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @user = User.new
    @users = User.all
    # devlop環境mysqlで作ってしまったためこのスコープ使用できないのでif文追加..直したい
    if Rails.env.production?
      @cleaning_places = CleaningPlace.order_name.all
    else
      @cleaning_places = CleaningPlace.all.order(:name)
    end

    return if @cleaning_places.empty?

    @date = @cleaning_places[0].updated_at.strftime('%m月 %d日')
  end
end
