class UsersController< ApplicationController
  
  def index
  end
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    @recommendations = @user.recommendations
    @open_contracts = @user.contracts.where(complete: false)
    @complete_contracts = @user.contracts.where(complete: true)
    ratings = @user.ratings.where("score is not null").collect { |rating| rating.score }
    total = ratings.inject{ |sum, x| sum + x }
    @rating = (total / ratings.count) rescue 0
  end
  
  def edit
    @states = State.all.collect do |state| 
      { 
        name: state.name, 
        id: state.id,
        cities: state.cities.collect { |city| { name: city.name, id: city.id } }
      }
    end
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(params[:user])
      flash[:message] = "User Account Successfully Updated"
      redirect_to user_path(@user)
    else
      flash[:error] = "Problem Saving User Profile"
      render :action => 'edit'
    end
  end
  
  def profile
    @posts = current_user.posts
    @recommendations = current_user.recommendations
    @open_contracts = current_user.contracts.where(complete: false)
    @complete_contracts = current_user.contracts.where(complete: true)
    ratings = current_user.ratings.where("score is not null").collect { |rating| rating.score }
    total = ratings.inject{ |sum, x| sum + x }
    @rating = (total / ratings.count) rescue 0
    render :profile
  end
  
end