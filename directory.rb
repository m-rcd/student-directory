@students = []

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
  puts '9. Exit'
end

def show_students
  print_header
  print_students_list
  print_footer
end

def save_students
  file = File.open('students.csv', 'w')
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(',')
    file.puts csv_line
  end
  file.close
end

def load_students(filename = 'students.csv')
  file = File.open(filename, 'r')
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << { name: name, cohort: cohort}
  end
  file.close
end

def try_load_students
  filename = ARGV.first
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
  when '1'
    input_students
  when '2'
    show_students
  when '3'
    save_students
  when '4'
    load_students
  when '9'
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
  i = 0
  until i == @students.length
    puts "#{@students[i][:name]} (#{@students[i][:cohort]} cohort)"\
      ", hobbies: #{@students[i][:hobbies]}," \
      "country of birth: #{@students[i][:country_of_birth]}, " \
      "height: #{@students[i][:height]}"
    i += 1
  end
end

def print_footer
  puts "Overall, we have #{@students.count} great students "
end

interactive_menu
