class PostsController < ApplicationController
  def index
    @posts = Post.all
    @users = User.all
    @genres = Genre.all
    @instruments = Instrument.all
    @specialties = Specialty.all
  end
  
  def new
    @post = Post.new
    @genres = Genre.all
    @instruments = Instrument.all
    @specialties = Specialty.all
  end
  
  def create
    @post = Post.create(params[:post])
    params[:genre_ids].each { |genre_id| @post.genres << Genre.find(genre_id)} if params[:genre_ids]
    params[:instrument_ids].each { |instrument_id| @post.instruments << Instrument.find(instrument_id)} if params[:instrument_ids]
    params[:specialty_ids].each { |specialty_id| @post.specialties << Specialty.find(specialty_id)} if params[:instrument_ids]
    if @post.save
      redirect_to posts_path
    else
      flash[:error] = "Error Creating Post"
      render :action => :new
    end
  end
  
  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
    @instruments = Instrument.all
    @specialties = Specialty.all
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    @post.genres.destroy_all
    @post.instruments.destroy_all
    @post.specialties.destroy_all
    params[:genre_ids].each { |genre_id| @post.genres << Genre.find(genre_id)} if params[:genre_ids]
    params[:instrument_ids].each { |instrument_id| @post.instruments << Instrument.find(instrument_id)} if params[:instrument_ids]
    params[:specialty_ids].each { |specialty_id| @post.specialties << Specialty.find(specialty_id)} if params[:instrument_ids]
    if @post.save
      redirect_to posts_path
    else
      flash[:error] = "Error Creating Post"
      render :action => :new
    end
  end
  
  def search
    statement = create_sql_statement
    @posts = Post.joins(:instruments, :genres, :specialties).where(statement).uniq
    return_hash = @posts.collect do |post|
      [
        post.created_at.strftime("%A %B %d %Y at %I:%M %p"), 
        post.user.email, 
        post.subject, 
        post.body, 
        post.instruments.collect { |instrument| instrument.name }.join(', '), 
        post.genres.collect { |genre| genre.name }.join(', '), 
        post.specialties.collect { |specialty| specialty.name }.join(', '),
        edit_post_path(post)
      ]
    end
    @users = User.all
    render json: { posts: return_hash }
  end
  
  private
  
  def create_sql_statement
    statement = {}

    statement[:users] = "posts.user_id in (#{params[:users].join(',')})" if params[:users]
    statement[:instruments] = "instruments_posts.instrument_id in (#{params[:instruments].join(',')})" if params[:instruments]
    statement[:genres] = "genres_posts.genre_id in (#{params[:genres].join(',')})" if params[:genres]
    statement[:specialties] = "specialties_posts.specialty_id in (#{params[:specialties].join(',')})" if params[:specialties]
    
    ret = statement.values.compact.join(' and ')
    
    ret
  end
end