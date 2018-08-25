require 'csv'
@students = []
@input_students_count = 0

def input_students
  puts 'Please enter the names of the students'
  puts 'To finish, just hit return twice'
  name = STDIN.gets.chomp
  until name.empty?
    @students << student_info(name)
    if @students.count == 1
      puts 'Now we have 1 student'
    else
      puts "Now we have #{@students.count} students"
    end
    puts 'Please enter another student'
    name = STDIN.gets.chomp
    @input_students_count += 1
  end
end

def student_info(name)
  puts 'Please enter their cohort'
  cohort = STDIN.gets.chomp.to_sym
  cohort = 'november' if cohort == ''
  puts 'Please enter their hobbies'
  hobbies = STDIN.gets.chomp
  puts 'Please enter their country of birth'
  country_of_birth = STDIN.gets.chomp
  puts 'Please enter their height'
  height = STDIN.gets.chomp
  student = { name: name, cohort: cohort, hobbies: hobbies,
              country_of_birth: country_of_birth, height: height }
  return student unless student.empty?
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  puts '1. Input the students'
  puts '2. Show the students'
  puts '3. Save the list to students.csv'
  puts '4. Load the list from students.csv'
  puts '5. Exit'
end

def show_students
  print_header
  print_students_list
  print_footer
end

def save_students
  puts 'Enter the name of the file'
  file_name = STDIN.gets.chomp
  CSV.open(file_name, 'wb') do |csv|
    @students.each do |student|
      student_data = [student[:name], student[:cohort], student[:hobbies],
                      student[:country_of_birth], student[:height]]
      csv << student_data
    end
  end
end

def load_students(filename)
  file = File.open(filename, 'r')
  CSV.foreach(filename) do |row|
    name, cohort, hobbies, country_of_birth, height = row
    @students << { name: name, cohort: cohort.to_sym, hobbies: hobbies.to_sym,
                   country_of_birth: country_of_birth.to_sym, 
                   height: height.to_sym}
  end
end

def try_load_students
  puts 'Please enter a filename'
  filename = STDIN.gets.chomp
  filename = 'students.csv' if filename.nil?
  if File.exist?(filename)
    load_students(filename)
    puts "Loaded #{@students.count - @input_students_count} students "\
      "from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist."
    exit
  end
end

def process(selection)
  case selection
  when '1'
    input_students
  when '2'
    show_students
  when '3'
    save_students
    puts 'Students list has been saved to students.csv'
  when '4'
    try_load_students
  when '5'
    exit
  else
    puts "I don't know what you mean, try again"
  end
end

def print_header
  puts 'The students of Villains Academy'
  puts '-------------'.center(30)
end

def print_students_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"\
      ", hobbies: #{student[:hobbies]}," \
      " country of birth: #{student[:country_of_birth]}, " \
      "height: #{student[:height]}"
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students "
end

interactive_menu
try_load_students
