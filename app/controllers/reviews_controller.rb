class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe

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

  def edit
    authorize @review
  end

  def update
    authorize @review
    if @review.update(review_params)
      redirect_to recipe_path(@recipe)
    else
      render :new, status: :unprocessable_entity
    end
  end


  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def set_recipe
    @recipe = Recipe.find_by(id: params[:id])
  end
end
