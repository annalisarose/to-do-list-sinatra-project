require 'pry'
class ListsController < ApplicationController

  get "/lists" do
    if logged_in?
      @user = current_user
      @lists = @user.lists.all
      erb :"/lists/index.html"
    else
      redirect to "/"
    end
  end

  get "/lists/new" do
    if logged_in?
      @user = current_user
      erb :"/lists/new.html"
    else
      redirect to "/"
    end
  end

  post "/lists" do
    @user = current_user
    #if title already exists, tell user they need to create another title
    if @user.lists.exists?(title: params[:title])
      flash[:title] = "*title is already taken"
           #binding.pry
      erb :"/lists/new.html"
    else
      @list = List.create(:title => params["title"])
      params[:list][:checkitems].each_with_index do |item, index|
        if item["contents"] != ""
          @list.checkitems << Checkitem.create(:contents => params["list"]["checkitems"][index]["contents"])
        end
      end
      @list.save
      @user.lists << @list
      redirect "/lists/#{@list.slug}"
    end
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
    redirect to "/"
    end
  end

  patch "/lists/:slug" do
    if logged_in?
      #update items
      @list = current_user.lists.find_by_slug(params[:slug])
        if @list.title != params[:title]
          @list.update(title: params[:title])
        end
      #update items
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
      #save updated list
      @list.save
      redirect to "/lists/#{@list.slug}"
    else
      redirect to "/"
    end
  end

  delete "/lists/:slug/delete" do
    if logged_in?
      @list = current_user.lists.find_by_slug(params[:slug])
      @list.delete
      redirect to "/lists"
    else
      redirect to "/"
    end
  end

end
