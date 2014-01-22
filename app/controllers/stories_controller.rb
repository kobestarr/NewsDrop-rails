class StoriesController < ApplicationController

	# before we run the show, edit, update and destroy
	# lets find the story that we're talking about


	before_action :find_story, only: [:show, :edit, :update, :destroy] 

	# this now means that before running the actions given above (show, edit osv)
	# it finds the story first by funning the find story method

	# controlles manage the URLS the data from the models
	# and our HTML (CSS/javascript) views


	#first thing we are gonna add is the index
	#This is the form for the index
	def index
		@username = "funkyb" #added a username
		@righthere_rightnow = Time.now


		#@stories = ["Google", "Yahoo", "kobestarr", "iTunes", "dancing spiderman"]

		#set the variables @stories to all of the records in our story db

		#@stories = Story.order("votes_count desc, title asc" )


		# if it has ?sort=recent in the url then sort by 
		# created at
		# if it has nothing then do the popular ones

		if params[:sort] == "recent"
			#sort by created_at
			@stories = Story.order("created_at desc" )

		elsif params[:sort] == "featured"

			#sort by featured
			@stories = Story.where(is_featured: true)
					.order("is_featured desc, title asc" )

				
		else
			#sort by popular
			@stories = Story.order("votes_count desc, title asc" )
		end

		# this is where we are gonna add the pagination
		# overwrite the @stories variable with a paginated version
		# infor from documentation User.page(7).per(50)
		@stories = @stories.page(params[:page]).per(4)
		
	end

	# This is the individual story page - 
	# using story.fin

	def show
		# params[:id] is the number in the url that we are looking for
		# @story = Story.find(params[:id])
		
	end

	#this is the form for the new story
	def new
		#this new variable will go into the view
		#Story.new comes from the model

		@story = Story.new

	end


	#This is where the form data from the new.erb.view goes
	def create
		@story = Story.new(story_params)

		if @story.save

			#lets add a flash of content to tell the user we've added this
			#This could be a success/error message etc

			flash[:success] = "You've added a link yo!"

			#go back to the homepage
			redirect_to root_path
		

		else	
			render "new"

		end

	end	


	# show the edit form
	def edit
		# @story = Story.find(params[:id])
		
	end

	# actually update the database
	def update
		# @story = Story.find(params[:id])

		if @story.update(story_params)

			flash[:success] = "HOLLA! you've updated this story!"

			redirect_to story_path(@story)
		
		else

			render "edit"

		end

	end

	#actually destroy the record in the database

	def destroy
		# @story = Story.find(params[:id])

		@story.destroy

		flash[:success] = "you BASTARD! - you just deleted iT"

		redirect_to root_path
		
	end


	# shortcut for getting form data
	def story_params
		params.require(:story).permit(:title, :description, :url, :tag_list)

	end

	# shortcut for finding the story from the url
	# find_story isnt a part of rails - it has been made up oursels
	def find_story
		@story = Story.find(params[:id])
		
	end
		

end
