require './input_functions'

# Complete the code below
# Use input_functions to read the data from the user
class Race
	attr_accessor :description, :id, :time, :location
	def initialize (description, id, time, location)
		@description = description
		@id = id
		@time = time
		@location = location
	end
end

def read_a_race()
	# put more code here
	race_description = read_string('Enter race description:')
	race_id = read_integer('Enter id: ')
	race_time = read_string('Enter time:')
	race_location = read_string('Enter location: ')
	race = Race.new(race_description, race_id, race_time, race_location)
	return race
end

def read_races()
	count = read_integer('How many races are you entering:')
	races = Array.new()
	index = 0
	while index < count
	race = read_a_race()
	 races << race
	 index += 1
	end
	return races
end

def print_a_race(race)
	print("Race description ", race.description ,"\n")
	print("ID ", race.id,"\n")
	print("Time ", race.time,"\n")
	print("Location ", race.location,"\n")
end

def print_races(races)
	i = 0
	c = races.length
	while (i < c)
    	print_a_race(races[i])
    	i += 1
	end
end

def main()
	races = read_races()
	print_races(races)
end

main()
