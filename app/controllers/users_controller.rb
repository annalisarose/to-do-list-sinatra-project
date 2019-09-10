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
   elsif User.find_by_slug(params[:username].downcase.gsub(" ","-"))
     flash.now[:message] = "username '#{params[:username]}' is already taken"
     erb :'users/new.html'
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
    redirect_if_not_logged_in

    @user = User.find_by_slug(params[:slug])
    erb :"/users/index.html"
  end

  get '/logout' do
    redirect_if_not_logged_in

    session.destroy
    redirect to '/'
  end

end
