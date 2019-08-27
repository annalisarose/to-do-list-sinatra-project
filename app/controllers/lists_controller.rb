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
    binding.pry
    @user = current_user
    @list = List.create(:title => params["title"])
    params[:list][:checkitems].each_with_index do |item, index|
      if item["contents"] != ""
      @list.checkitems << Checkitem.create(:contents => params["list"]["checkitems"][index]["contents"])
      end
    end
    @list.save
    @user.lists << @list
    redirect "/lists/#{@list.id}"
  end

  # GET: /lists/5
  get "/lists/:id" do
    if logged_in?
      @list = List.find_by_id(params[:id])
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

  patch "/lists/:id" do
    if logged_in?
      binding.pry
      #update items
      @list = current_user.lists.find_by_id(params[:id])
      @checkitems = @list.checkitems
      @checkitems.each_with_index do |item, index|
        item.update(contents: params[:checkitems][index]["contents"])
      end
      #delete checked items
      if params["completed"]
        Checkitem.delete(params["completed"].keys.map {|k| k.to_i})
      end
      #add new items
      params[:list][:checkitems].each_with_index do |item, index|
        if item["contents"] != ""
        @checkitems << Checkitem.create(:contents => params["list"]["checkitems"][index]["contents"])
        end
      end
      @list.save
      redirect to "/lists/#{@list.id}"
    else
      redirect to "/login"
    end
  end

  # DELETE: /lists/5/delete
  delete "/lists/:id/delete" do
    if logged_in?
      @list = current_user.lists.find_by_id(params[:id])
      @list.delete
      redirect to "/lists"
    else
      redirect to '/login'
    end
  end

end
