class RatingsController < ApplicationController
  
  def edit
    @rating = Rating.find(params[:id])
  end
  
  def update
    @rating = Rating.find(params[:id])
    if @rating.update_attributes(params[:rating])
      contract = @rating.contract
      contract.update_attributes(complete: true) unless contract.ratings.collect { |rating| rating.score }.include?(nil)
      flash[:notice] = 'Rating successfully submitted'
      redirect_to '/profile'
    else
      flash[:error] = 'There was an error submitting the rating'
      redirect_to '/profile'
    end
  end
end