NewsDrop::Application.routes.draw do
  

  #URLS for active  admin
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
#The routes files matches our URLS up with
#our controllers

#I want to add in all of the REST url for the stories
#E.g. InDEX, show, new, create, edit update, destroy

resources :stories do

# this is called a nested resource
#this means that the URLS for comments are on the 
#urls for stories

  resources :comments #we place the resources inside the nest
  # so that it links in with stories and is not a seperate entity

resources :votes  
end

 #i.e. the controller "stories created in 
#the rails generate controller stories"

#




# lets then add in a homepage
root "stories#index" # this is saying look at our controller and look at the 
#index inside it


end
