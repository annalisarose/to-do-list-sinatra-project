class ListsController < ApplicationController

  # GET: /lists
  get "/lists" do
    if logged_in?
      @lists = List.all
      erb :"/lists/index.html"
    else
      redirect to "/"
    end
  end

  # GET: /lists/new
  get "/lists/new" do
    if logged_in?
      erb :"/lists/new.html"
    else
      redirect to "/"
    end
  end

  # POST: /lists
  post "/lists" do
    @user = current_user
    @list = List.create(:title => params["title"])
    unless params[:checkitems][:contents].empty?
      @list.checkitems << Checkitem.create(:contents => params["checkitems"]["contents"])
    end
    @list.save
    @user.lists << @list
    redirect "/lists/#{@list.id}"
  end

  # GET: /lists/5
  get "/lists/:id" do
    erb :"/lists/show.html"
  end

  # GET: /lists/5/edit
  get "/lists/:id/edit" do
    erb :"/lists/edit.html"
  end

  # PATCH: /lists/5
  patch "/lists/:id" do
    redirect "/lists/:id"
  end

  # DELETE: /lists/5/delete
  delete "/lists/:id/delete" do
    redirect "/lists"
  end
end
