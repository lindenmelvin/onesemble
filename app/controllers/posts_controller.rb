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
        post.create_date(post.start_date, post.all_day),
        post.create_date(post.end_date, post.all_day),
      ]
    end
    @users = User.all
    render json: { posts: return_hash }
  end
  
  private
  
  def create_sql_statement
    statement = {}

    statement[:date] = construct_date_statement if params[:post][:'start_date(1i)'] != ''
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
  
  def construct_date_statement
    if params[:post][:'start_date(4i)']
      start_date = DateTime.new(params[:post][:'start_date(1i)'].to_i, params[:post][:'start_date(2i)'].to_i, params[:post][:'start_date(3i)'].to_i, params[:post][:'start_date(4i)'].to_i, params[:post][:'start_date(5i)'].to_i)
    else
      start_date = DateTime.new(params[:post][:'start_date(1i)'].to_i, params[:post][:'start_date(2i)'].to_i, params[:post][:'start_date(3i)'].to_i)
    end
    
    if params[:post][:'end_date(4i)']
      end_date = DateTime.new(params[:post][:'end_date(1i)'].to_i, params[:post][:'end_date(2i)'].to_i, params[:post][:'end_date(3i)'].to_i, params[:post][:'end_date(4i)'].to_i, params[:post][:'end_date(5i)'].to_i)
    else
      end_date = DateTime.new(params[:post][:'end_date(1i)'].to_i, params[:post][:'end_date(2i)'].to_i, params[:post][:'end_date(3i)'].to_i)
    end

    return "posts.start_date >= #{to_timestamp('#{start_date}', 'YYYY-MM-dd HH:MI:SS.MS')} and posts.end_date <= #{to_timestamp('#{end_date}', 'YYYY-MM-dd HH:MI:SS.MS')}"
  end
  
end