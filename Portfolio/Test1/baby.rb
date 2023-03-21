require './input_functions'

# Complete the code below
# Use input_functions to read the data from the user
class Baby
	attr_accessor :name, :weight, :gender, :ward
	def initialize (name, weight, gender, ward)
		@name = name
		@weight = weight
		@gender = gender
		@ward = ward
	end
end

def read_a_baby()
	# put more code here
	baby_name = read_string('Enter baby name:')
	baby_weight = read_float('Enter birth weight (kgs): ')
	baby_gender = read_string('Enter gender:')
	baby_ward = read_string('Enter ward: ')
	baby = Baby.new(baby_name, baby_weight, baby_gender, baby_ward)
	return baby
end

def read_babies()
	count = read_integer('How many babies are you entering:')
	babies = Array.new()
	index = 0
	while index < count
	baby = read_a_baby()
	 babies << baby
	 index += 1
	end
	return babies
end

def print_a_baby(baby)
	print("Name: ", baby.name ,"\n")
	printf("Birth weight: %.2f\n", baby.weight)
	print('Gender : ' , baby.gender,"\n")
	print('Ward: ', baby.ward,"\n")
end

def print_babies(babies)
	i = 0
	c = babies.length
	while (i < c)
    	print_a_baby(babies[i])
    	i += 1
	end
end

def main()
	babies = read_babies()
	print_babies(babies)
end

main()
