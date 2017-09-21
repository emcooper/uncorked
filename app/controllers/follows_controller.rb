class FollowsController < ApplicationController

  def create
    case params[:target_type]
    when "Venue"
      target = Venue.find(params[:target_id])
      create_follow(target)
    when "Wine"
      create_wine_follow
    when "User"
      target = User.find(params[:target_id])
      create_follow(target)
    end
  end

  def create_follow(target)
    follow = current_user.follows.new(target: target)
    if follow.save
      follow.report_follow
      redirect_to follow.target, success: "#{follow_params[:target_type]} successfully followed!"
    else
      redirect_to follow.target, warning: "There was a problem! #{follow_params[:target_type]} was not followed!"
    end
  end

  def create_wine_follow
    target = Wine.find_or_create_by(code: params[:target_params][:code]) do |wine|
      wine.name = params[:target_params][:name]
    end
    follow = current_user.follows.new(target: target)
    if follow.save
      follow.report_follow
      redirect_to wine_path(target.code), success: "#{follow_params[:target_type]} successfully followed!"
    else
      redirect_to wine_path(target.code), warning: "There was a problem! #{follow_params[:target_type]} was not followed!"
    end
  end

  def destroy
    follow = Follow.find_by(id: params[:id])
    session[:return_to] ||= request.referer
    if follow.user_id == current_user.id
      follow.report_unfollow
      follow.destroy
      redirect_to session.delete(:return_to), success: "#{follow.target.class} successfully unfollowed!"
    else
      redirect_to session.delete(:return_to), warning: "You do not have permission to do this."
    end
  end

  private
    def follow_params
      params.permit(:user_id, :target_id, :target_type)
    end
end
