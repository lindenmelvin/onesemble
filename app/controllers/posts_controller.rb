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
    @posts = Post.includes(:user).where("user_id in (#{params[:users].join(',')})") rescue []
    return_hash = @posts.collect { |post| [post.created_at.strftime("%A %B %d %Y at %I:%M %p"), post.user.email, post.subject, post.body]}
    @users = User.all
    render json: { posts: return_hash }
  end
end