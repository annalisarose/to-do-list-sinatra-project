class ListsController < ApplicationController

  # GET: /lists
  get "/lists" do
    erb :"/lists/index.html"
  end

  # GET: /lists/new
  get "/lists/new" do
    erb :"/lists/new.html"
  end

  # POST: /lists
  post "/lists" do
    redirect "/lists"
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
