class RecommendationsController < ApplicationController
  
  def new
    @recommendation = Recommendation.new
    @user_id = params[:user_id]
  end
  
  def create
    if Recommendation.create(params[:recommendation])
      flash[:notice] = 'Recommendation Created'
      redirect_to user_path(current_user)
    else
      flash[:error] = 'There was an error saving the recommendation'
      redirect_to user_path(current_user)
    end
  end
  
  def edit
    @recommendation = Recommendation.find(params[:id])
  end
  
  def update
    @recommendation = Recommendation.find(params[:id])
    if @recommendation.update_attributes(params[:recommendation])
      flash[:notice] = 'Recommendation Update'
      redirect_to user_path(current_user)
    else
      flash[:error] = 'There was an error saving the recommendation'
      redirect_to user_path(current_user)
    end
  end
  
  def destroy
    @recommendation = Recommendation.find(params[:id])
    
    if @recommendation.destroy
      flash[:notice] = 'Recommendation Deleted'
      redirect_to user_path(current_user)
    else
      flash[:errors] = 'Unable to delete Recommendation'
      redirect_to user_path(current_user)
    end
  end
  
end