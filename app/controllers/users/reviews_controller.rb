class Users::ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    reviewable = params["review"]
    if reviewable["reviewable_type"] == "wines"
      wine = Wine.find(reviewable["reviewable_id"])
      review = wine.reviews.create(review_params)
    else
      venue  = Venue.find(reviewable["reviewable_id"])
      review = venue.reviews.create(review_params)
    end
    if review.save
      flash[:success] = "Review successfully submitted!"
      redirect_to user_path(current_user)
      badge_allocation
    else
      render :new
    end
  end

  private
    def review_params
      params.require(:review).permit(:description, :rating, :user_id, :reviewable_id, :reviewable_type)
    end

    def badge_allocation
      if current_user.reviews.count == 10
        star_performer = Badge.where(name: "All Star Performer")
        current_user.badges << star_performer
        flash[:success] = "You just received the 'All Star Reviewer' Badge!"
      end
    end
end
