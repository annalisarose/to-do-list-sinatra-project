require 'pry'
class ListsController < ApplicationController

  # GET: /lists
  get "/lists" do
    if logged_in?
      @lists = current_user.lists.all
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
    #binding.pry
    params[:list][:checkitems].each_with_index do |item, index|
      if item["contents"] != ""
      @list.checkitems << Checkitem.create(:contents => params["list"]["checkitems"][index]["contents"])
      end
    end
    @list.save
    @user.lists << @list
    redirect "/lists/#{list.slug}"
  end

  # GET: /lists/5
  get "/lists/:slug" do
    if logged_in?
      @list = List.find_by_slug(params[:slug])
      if @list && @list.user_id == current_user.id
        @checkitems = @list.checkitems.all
        erb :"/lists/show.html"
      else
        redirect to "/lists"
      end
    else
    redirect to "/login"
    end
  end

  # GET: /lists/5/edit
#  get "/lists/:id/edit" do
#    erb :"/lists/edit.html"
#  end

  # PATCH: /lists/5
  patch "/lists/:id" do
    redirect "/lists/:id"
  end

  # DELETE: /lists/5/delete
  delete "/lists/:id/delete" do
    redirect "/lists"
  end

end
