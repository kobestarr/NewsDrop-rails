class Story < ActiveRecord::Base

	# this code above takes some things from "active record" which handles things like form 
	# story.all and URL 

	# this is an association in rail
	# our story has many comments
	has_many :comments
	has_many :votes

	#set up acts as taggavle
	acts_as_taggable


# This is our story and the rules for the model. This code below ensures that the code
# is validated for the presence of the text in a field and in the case of the url that
# it is unique
	# validates :title, presence: true
	validates :title, length: {minimum: 5, message: "come on - make the message longer please. Twat!"}
	validates :description, presence: true
	validates :url, presence: true, uniqueness: {message:"This url has already been submitted dude!"}

# we want to overwite the url structure in "active record"
# active record is the rails way to manage models
# to_param is the method we want to overwrite

# this parameterize lowecases anything and takes out accents from certain characters

	def to_param
		"#{id}-#{title.parameterize}"
		# the "#{}" - is saying that in the string replace it with something
		# in this case it is the id
		
	end

#This is my OWN shortcut to make nice clean urls for our users
#this will remover the www and the http:// from the url

	def nice_url
		# i want to take the url and remove the http and www.
		# gsub is global substitution to replace the whole string

		url.gsub("http://","" ).gsub("www.", "").gsub("https://", "")


	end
	

end
