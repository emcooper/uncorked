class Users::ReviewsController < ApplicationController
  def new
    # session[:return_to] = request.referer
    if params["reviewable_type"] == "wines"
      wine = Wine.find_or_create_by(code: params[:wine_data][:code]) do |wine|
        wine.name = params[:wine_data][:name]
      end
    end
    params[:reviewable_id] = wine.id
    @review = Review.new
  end

  def create
    reviewable = review_params
    if reviewable["reviewable_type"] == "wines"
      wine  = Wine.find(reviewable["reviewable_id"])
      review = wine.reviews.create(review_params)
    else
      venue  = Venue.find(reviewable["reviewable_id"])
      review = venue.reviews.create(review_params)
    end
    if review.save
      review.report_review
      flash[:success] = "Review successfully submitted!"
      redirect_to session.delete(:return_to)
      Badge.badge_allocation(current_user)
    else
      render :new
    end
  end

  private
    def review_params
      params.require(:review).permit(:description, :rating, :user_id, :reviewable_id, :reviewable_type)
    end
end
