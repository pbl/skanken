require 'csv'
class Member < ActiveRecord::Base
	has_many :contacteds, dependent: :destroy
	has_many :jobs, dependent: :destroy
	def self.import(file)
		# Read the imported csv into variable
		spreadsheet = CSV.read(file.path)

		index = 0

		# Iterate through all rows
	  spreadsheet.each do |row|
	  	if index == 0 
	  		index += 1
		  else
		  	# Create a new member
		  	new_member = Member.new

			  #x, datum inskriven?
			  new_member.dateAdded = row[0]

			  #Namn
			  first_name = row[1]
			  
			  #Efternamn
			  last_name = row[2]

			  new_member.name = first_name + " " + last_name # is this right?

			  #Personnummer,
			  new_member.personId = row[3]

			  #Telefonnummer,
			  new_member.mobile = row[4]

			  #Vill Jobba,
			  
			  #Email,
			  new_member.email = row[6]
			  
			  #Termin,
			  new_member.term = row[7]

			  #Senast kontaktad,
			  #7

			  #Kommentarer,
				#8

			  #Jobbarkort

			  # Save to database
			  new_member.save

			  index += 1
			end
	  end
	end
end
