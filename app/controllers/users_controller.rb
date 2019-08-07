class UsersController < ApplicationController

  get "/signup" do
    if !logged_in?
      erb :'users/new.html'
    else
      redirect to "/users/#{current_user.id}"
    end
  end

  post "/signup" do
   if params[:username] == "" || params[:password] == ""
     redirect to "/signup"
   else
     user = User.new(:username => params[:username], :password => params[:password])
     user.save
     session[:user_id] = user.id
     redirect to "/users/#{user.id}"
   end
 end

  post "/" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/users/#{user.id}"
    else
      redirect to "/"
    end
  end

  # GET: /users/5
  get "/users/:id" do
    if logged_in?
      @user = current_user
      erb :"/users/index.html"
    else
      redirect to "/"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
