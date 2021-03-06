class ListsController < ApplicationController

  get "/lists" do
    redirect_if_not_logged_in

    @user = current_user
    @lists = @user.lists.all
    erb :"/lists/index.html"
  end

  get "/lists/new" do
    redirect_if_not_logged_in
    @user = current_user
    erb :"/lists/new.html"
  end

  post "/lists" do
    redirect_if_not_logged_in
    @user = current_user
    if params[:title] == ""
      flash.keep[:blank] = "*title cannot be blank"
      redirect to "/lists/new"
    end
    #if title already exists, tell user they need to create another title
    if @user.lists.find_by_slug(params[:title].downcase.gsub(" ","-"))
      flash.keep[:title] = "*title '#{params[:title]}' is already taken"
      #make provisions for empty title field!
      redirect to "/lists/new"
    else
      @list = List.create(:title => params["title"])
      params[:list][:checkitems].each_with_index do |item, index|
        if item["contents"] != ""
          #use create method to instantiate checkitem knowing about its list already
          @list.checkitems.create(:contents => params["list"]["checkitems"][index]["contents"])
        end
      end
      @list.save
      @user.lists << @list
      redirect "/lists/#{@list.slug}"
    end
  end

  get "/lists/:slug" do
    redirect_if_not_logged_in

    @list = current_user.lists.find_by_slug(params[:slug])
    if @list && @list.user_id == current_user.id
      @checkitems = @list.checkitems.all
      erb :"/lists/show.html"
    else
      redirect to "/lists"
    end
  end

  patch "/lists/:slug" do
    redirect_if_not_logged_in

      @user = current_user
      #update title
      @list = @user.lists.find_by_slug(params[:slug])
        if @list.title != params[:title]
          if @user.lists.find_by_slug(params[:title].downcase.gsub(" ","-"))
            flash.keep[:taken] = "*title '#{params[:title]}' is already taken"
            redirect to "/lists/#{@list.slug}"
          else
            @list.update(title: params[:title])
          end
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
  end

  delete "/lists/:slug/delete" do
    redirect_if_not_logged_in

    @list = current_user.lists.find_by_slug(params[:slug])
    @list.delete
    redirect to "/lists"
  end

end
