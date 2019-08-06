class CheckitemsController < ApplicationController

  # GET: /checkitems
  get "/checkitems" do
    erb :"/checkitems/index.html"
  end

  # GET: /checkitems/new
  get "/checkitems/new" do
    erb :"/checkitems/new.html"
  end

  # POST: /checkitems
  post "/checkitems" do
    redirect "/checkitems"
  end

  # GET: /checkitems/5
  get "/checkitems/:id" do
    erb :"/checkitems/show.html"
  end

  # GET: /checkitems/5/edit
  get "/checkitems/:id/edit" do
    erb :"/checkitems/edit.html"
  end

  # PATCH: /checkitems/5
  patch "/checkitems/:id" do
    redirect "/checkitems/:id"
  end

  # DELETE: /checkitems/5/delete
  delete "/checkitems/:id/delete" do
    redirect "/checkitems"
  end
end
