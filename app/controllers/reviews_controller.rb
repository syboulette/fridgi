class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reviews = policy_scope(Reviews).all
  end

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

  def destroy
    authorize @review
    @review.destroy
    redirect_to recipe_path(@recipe), notice: "The review has been deleted!"
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
