class RequestsController < ApplicationController
  
  def index
    @pending_requests = Request.where(receiver_id: current_user.id, pending: true)
    @sent_requests = Request.where(sender_id: current_user.id)
  end
  
  def create
    if Request.create(params[:request])
      flash[:notice] = "Request Sent"
      redirect_to user_path(current_user)
    else
      flash[:errors] = "Thre was an error sending your request"
      redirect_to user_path(current_user)
    end
  end
  
  def update
    @request = Request.find(params[:id])
    
    if params[:request][:accepted] == 'true'
      @contract = Contract.create
      user_a = User.find(params[:sender_id])
      user_b = User.find(params[:receiver_id])
      @contract.users << user_a
      @contract.users << user_b
      @contract.ratings.create(user_id: user_a.id, rater_id: user_b.id)
      @contract.ratings.create(user_id: user_b.id, rater_id: user_a.id)
    end
    
    if @request.update_attributes(params[:request])
      flash[:notice] = "Successfully responsed to request"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Unable to respond to reqest"
      redirect_to messages_path
    end
  end
end