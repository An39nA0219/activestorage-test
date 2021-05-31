class UsersController < ApplicationController
  def index
    users = User.all.order(created_at: "DESC")
    users = users.map{|user| user.attributes}
    users.each do |user|
      b = User.find(user["id"])
      if b.user_img.attached?
        user["img"] = url_for(b.user_img)
      else
        user["img"] = nil
      end
    end

    render json: {
      users: users
    }
  end

  def show
    user = User.find(params[:id])
    render json: {
      user: user.name,
      img: img(user)
    }
  end

  def create
    user = User.new(user_params)
    if user.save!
      if user_img_params[:user_img].present?
        user.parse_base64(user_img_params[:user_img], user.id)
      end
      render json: {
        status: "success",
        user: user
      }
    else
      render json: {
        status: "failed"
      }
    end
  end

  private

  def user_params
    params.permit(:name)
  end

  def user_img_params
    params.permit(:user_img)
  end

  def img(user)
    if user.user_img.attached?
      return url_for(user.user_img)
    else
      return nil
    end
  end
end
