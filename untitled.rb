def read_file datos
  contents = []
  File.open(datos, 'r') { |text| contents = text.readlines }
  return contents
end


def create_array_hash(file)
  names = names(file)
  grades = grades(file, names)
  hash = hash(names, grades)
  hash
end

def names(file)
  names = []
  file.each { |row| names.push(get_name_file(row)) }
  names
end

def get_name_file(str)
  name = ''
  i = 0
  str.each_char { i += 1 until str[i] == ',' }
  for j in 0..i - 1 do
    name += str[j]
  end
  name
end

def grades(file, names)
  grades = []
  notas = ''
  i = 0
  file.each do |row|
    row.slice! names[i]
    notas = grade_list(row)
    grades.push(notas)
    i += 1
  end
  grades
end

read_file ("info.csv").get_name_file.create_array_hash