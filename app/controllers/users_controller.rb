require 'pry'

class UsersController < ApplicationController

  get "/signup" do
    if !logged_in?
      erb :'users/new.html'
    else
      redirect to "/users/#{current_user.slug}"
    end
  end

  post "/signup" do
   if params[:username] == "" || params[:password] == ""
     redirect to "/signup"
   elsif User.exists?(username: params[:username])
     flash[:message] = "username is already taken"
    #binding.pry
     redirect to "/signup"
   else
     user = User.new(:username => params[:username], :password => params[:password])
     user.save
     session[:user_id] = user.id
     redirect to "/users/#{user.slug}"
   end
 end

  get "/" do
    if logged_in?
      redirect to "/users/#{current_user.slug}"
    else
      erb :welcome
    end
  end

  post "/" do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to "/users/#{user.slug}"
    else
      redirect to "/"
    end
  end

  get "/users/:slug" do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      erb :"/users/index.html"
    else
      redirect to "/"
    end
  end

  get '/logout' do
  if logged_in?
    session.destroy
    redirect to '/'
  else
    redirect to '/'
  end
end

end
