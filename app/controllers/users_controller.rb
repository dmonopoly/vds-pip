#
# Authors: Jeff Cox, David Zhang
# Copyright Syracuse University
#

class UsersController < ApplicationController
  before_filter :require_site_admin # method defined in ApplicationController
  load_and_authorize_resource # from cancan gem
	
  def new  
    @user = User.new
  end  
    
  # POST /users/create
  # This action is designed to handle the submission of an html form for an admin.
  # For the similar api method, see ApiController#createuser
  def create  
    @user = User.new(params[:user])  
    if @user.save  
      redirect_to root_url, :notice => "Signed up!"  
    else  
      render "new"  
    end  
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated."
      redirect_to users_path
    else
      render :action => :edit
    end
  end
  
  def index
    @site_admins = User.where(:role => 'site_admin')
    @project_managers = User.where(:role => 'project_manager')
    @normal_users = User.where(:role => 'normal_user')
  end
end
