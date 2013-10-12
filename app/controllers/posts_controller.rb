class PostsController < ApplicationController
  def index
    @posts = Post.all
    @users = User.all
  end
  
  def new
    @post = Post.new
  end
  
  def create    
    if Post.create(params[:post])
      redirect_to posts_path
    else
      flash[:error] = "Error Creating Post"
      render :action => :new
    end
  end
  
  def search
    @posts = []
    if params[:users]
      @posts = Post.where("user_id in (#{params[:users].join(',')})")
    end
    @users = User.all
    render action: :index
  end
end