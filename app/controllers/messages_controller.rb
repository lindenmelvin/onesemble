class MessagesController < ApplicationController
  
  def index
    @messages = Message.where(:receiver_id => current_user.id)
  end
  
  def show
    @message = Message.find(params[:id])
  end
  
  def new
    if params[:parent_id]
      @message = Message.new(:parent_id => params[:parent_id])
    else
      @message = Message.new
    end
    @receiver_id = params[:receiver_id]
  end
  
  def create
    if Message.create(params[:message])
      flash[:notice] = "Message Sent!"
      redirect_to posts_path
    else
      flash[:error] = "Unable to send message"
      render action: :new
    end
  end
end