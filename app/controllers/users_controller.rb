class UsersController< ApplicationController
  
  def edit
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
end