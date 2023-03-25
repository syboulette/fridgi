class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @review = @recipe.reviews.build(review_params)

    authorize @review

    if @review.save
      redirect_to recipe_path(@recipe)
    else
      render "recipes/show", status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
