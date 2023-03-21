require 'date'
require './input_functions'

# Multiply metres by the following to get inches:
INCHES = 39.3701

# Insert into the following your hello_user code
# from task 1.3P and modify it to use the functions
# in input_functions

def main()

  # HOW TO USE THE input_functions CODE
  # Example of how to read strings:

  s = read_string('What is your name?')
  puts("Your name is " + s + "!")

  a = read_string('What is your family name?')
  puts("Your family name is: " + a + "!")
  
  # Example of how to read integers:

  i = read_integer('What year were you born?')
  i = Date.today.year - i
  puts("So you are " + i.to_s + " years old")

  # Example of how to read floats:

  f = read_float('Enter your height in metres (i.e as a float): ')
  f = f * INCHES
  puts("Your height in inches is: ")
  puts(f.to_s)
  # Get the curent year from the system:

  y = Date.today.year
  puts("Finished")
continue = read_boolean('Do you want to continue?')
if (continue)
	# ok message here
  main()
else
    # good bye message here
    puts "ok, goodbye"
end
	 # Now if you know how to do all that
   # Copy in your code from your completed
	 # hello_user Task 1.3 P. Then modify it to
	 # use the code in input_functions.
   # use read_string for all strings (this will
   # remove all whitespace)
end

main()