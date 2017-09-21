class Users::ReviewsController < ApplicationController
  def new
    if params["reviewable_type"] == "wines"
      wine = Wine.find_or_create_by(code: params[:wine_data][:code]) do |wine|
        wine.name = params[:wine_data][:name]
      end
      params[:reviewable_id] = wine.id
    end
    session[:return_to] = request.referer
    @new_review_presenter = NewReviewPresenter.new
  end

  def create
    reviewable = review_params
    if reviewable["reviewable_type"] == "wines"
      wine  = Wine.find(reviewable["reviewable_id"])
      review = wine.reviews.create(review_params)
      wine.venues << Venue.find(review_params["venue_id"]) if review_params["venue_id"]
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
      redirect_to new_users_review_path(:reviewable_id => reviewable["reviewable_id"], :reviewable_type => reviewable["reviewable_type"])
    end
  end

  private
    def review_params
      (params["review"]["venue_id"] = Venue.find_by(name: params["review"]["venue"]).id) unless params["review"]["venue"].empty?
      params.require(:review).permit(:description, :rating, :user_id, :reviewable_id, :reviewable_type, :venue_id)
    end
end
