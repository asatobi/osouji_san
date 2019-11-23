# frozen_string_literal: true

class UsersController < ApplicationController

  def create
    @user = User.new(params_user)
    begin
      @user.save!
      redirect_to :root
    rescue StandardError
      redirect_to :root, alert: @user.errors.full_messages
    end
  end

  def edit
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      redirect_to :root
    else
      flash[:notice] = '削除失敗'
      render 'home/index'
    end
  end

  def params_user
    params.require(:user).permit(:name, :gender)
  end

end
