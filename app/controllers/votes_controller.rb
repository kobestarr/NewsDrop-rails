class VotesController < ApplicationController

	# just create a vote
	# no need for new.html.erb as it doesnt make much sense

	def create

		#as we are in votes controller the story is the story

		@story = Story.find(params[:story_id])
	
		@vote = @story.votes.create

		flash[:success] = "you've voted yo!"

		# redirect_to story_path(@story)

		if params[:back_to] == "home"
			#go to the homepage
			redirect_to root_path 
		else
			#go to the story page

			redirect_to story_path(@story)

		end	

	 end 



end
