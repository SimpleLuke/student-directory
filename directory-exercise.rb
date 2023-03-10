@students = []

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit" 
end

def import_student(store, data)
    store << data
end    

def input_students
    puts "Please enter the names of the students"
    puts "To finish, just hit return twice"

    name = STDIN.gets.chomp

    while !name.empty?
        # @students << {name: name, cohort: :november}
        import_student(@students,{name: name, cohort: :november, country: :unknow})
        puts "Now we have #{@students.count} students"
        name = STDIN.gets.chomp
    end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end
  
def print_students_list
  # @students.each_with_index do |student,index|
  #   if student[:name][0].upcase == 'T' && student[:name].length < 12 # only show name begins with 'T' and shorter than 12 characters
  #     puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
  #   end  
  # end
  count = @students.length
  while count > 0
    puts "#{@students[count-1][:name]} (#{@students[count-1][:cohort]} cohort) #{@students[count-1][:country]}".center(50)
    count -= 1
  end 
end
  
def print_footer
  puts "Overall, we have #{@students.count} great students"
end

def show_students
  print_header
  print_students_list
  print_footer
end

def save_students
  # open the file for writing
  file = File.open("students-exercise.csv", "w")

  @students.each do |student|
    student_data = [student[:name], student[:cohort], student[:country]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def load_students(filename = "students-exercise.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort, country = line.chomp.split(',')
    # @students << {name: name, cohort: cohort.to_sym}
    import_student(@students,{name: name, cohort: cohort.to_sym, country: country.to_sym})
  end
  file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? 

  if File.exist?(filename) 
    load_students(filename)
     puts "Loaded #{@students.count} from #{filename}"
  else 
    puts "Sorry, #{filename} doesn't exist."
    exit 
  end
end

def process(selection)
    case selection
      when "1"
        input_students
      when "2"
        show_students
      when "3"
        save_students  
      when "4"
        load_students  
      when "9"
        exit
      else
        puts "I don't know what you mean, try again"
    end
  end

def interactive_menu
  loop do
    print_menu 
    # selection = gets.chomp
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu