class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def index
    @reviews = policy_scope(Reviews).all
  end


  def new
    @review = Review.new
    authorize @review
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @review = @recipe.reviews.build(review_params)
    @review.user = current_user

    authorize @review

    if @review.save
      redirect_to recipe_path(@recipe)
    else
      render "recipes/show", status: :unprocessable_entity
    end
  end

  def destroy
    authorize @review
    @recipe = @review.recipe
    @review.destroy
    redirect_to recipe_path(@recipe), notice: "The review has been deleted!"
  end

  def edit
    authorize @review
  end

  def update
    authorize @review
    @recipe = @review.recipe
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

  def set_review
    @review = Review.find(params[:id])
  end

end
