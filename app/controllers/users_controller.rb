# frozen_string_literal: true

class UsersController < ApplicationController
  def create
    user = User.new(params_user)
    begin
      user.save!
      redirect_to :root, notice: "#{user.name}さんを追加しました"
    rescue StandardError => e
      logger.debug e.message
      redirect_to :root, alert: user.errors.full_messages
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy!
    redirect_to :root, notice: "#{user.name}さんを削除しました"
  end

  private

  def params_user
    params.require(:user).permit(:name, :gender)
  end
end
