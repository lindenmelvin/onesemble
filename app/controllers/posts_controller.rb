class PostsController < ApplicationController
  def index
    @posts = Post.all
    @states = State.all.collect do |state| 
      { 
        name: state.name, 
        id: state.id,
        cities: state.cities.collect { |city| { name: city.name, id: city.id } }
      }
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def new
    @post = Post.new
    @states = State.all.collect do |state| 
      { 
        name: state.name, 
        id: state.id,
        cities: state.cities.collect { |city| { name: city.name, id: city.id } }
      }
    end
  end
  
  def create
    # params[:post][:start_date] = create_date(params[:start_date])
    # params[:post][:end_date] = create_date(params[:end_date])
    @post = Post.create(params[:post])
    params[:genre_ids].each { |genre_id| @post.genres << Genre.find(genre_id)} if params[:genre_ids]
    params[:instrument_ids].each { |instrument_id| @post.instruments << Instrument.find(instrument_id)} if params[:instrument_ids]
    params[:specialty_ids].each { |specialty_id| @post.specialties << Specialty.find(specialty_id)} if params[:specialty_ids]
    if @post.save
      redirect_to posts_path
    else
      flash[:error] = "Error Creating Post"
      render :action => :new
    end
  end
  
  def edit
    @post = Post.find(params[:id])
    @states = State.all.collect do |state| 
      { 
        name: state.name, 
        id: state.id,
        cities: state.cities.collect { |city| { name: city.name, id: city.id } }
      }
    end
  end
  
  def update
    # params[:post][:start_date] = create_date(params[:start_date])
    # params[:post][:end_date] = create_date(params[:end_date])
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    @post.genres.destroy_all
    @post.instruments.destroy_all
    @post.specialties.destroy_all
    params[:genre_ids].each { |genre_id| @post.genres << Genre.find(genre_id)} if params[:genre_ids]
    params[:instrument_ids].each { |instrument_id| @post.instruments << Instrument.find(instrument_id)} if params[:instrument_ids]
    params[:specialty_ids].each { |specialty_id| @post.specialties << Specialty.find(specialty_id)} if params[:specialty_ids]
    if @post.save
      redirect_to post_path(@post)
    else
      flash[:error] = "Error Creating Post"
      render :action => :new
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    
    if @post.destroy
      redirect_to posts_path
    else
      flash[:errors] = 'Unable to delete post'
      render action: :index
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
        post_path(post),
        post.rate,
        post.hourly,
        post.type,
        (post.city.name rescue ''),
        (post.state.name rescue ''),
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

    if(params[:rate][:minimum].present? && params[:rate][:maximum].present?)
      statement[:rate] = "posts.rate between #{params[:rate][:minimum]} and #{params[:rate][:maximum]}"
    elsif(params[:rate][:minimum].present?)
      statement[:rate] = "posts.rate > #{params[:rate][:minimum]}"
    elsif(params[:rate][:maximum].present?)
      statement[:rate] = "posts.rate < #{params[:rate][:maximum]}"
    end
    
    statement[:type] = "posts.type = '#{params[:type]}'" if params[:type]

    statement[:city] = "posts.city_id = #{params[:city_id]}" if params[:city_id]
    statement[:state] = "posts.state_id = #{params[:state_id]}" if params[:state_id]
    
    ret = statement.values.compact.join(' and ')
    
    ret
  end
  
  def create_date(date_hash)
    hour = date_hash[:hour] || 0
    minute = date_hash[:minute] || 0
    
    return DateTime.new(date_hash[:year].to_i, date_hash[:month].to_i, date_hash[:day].to_i, hour.to_i, minute.to_i)
  end
end