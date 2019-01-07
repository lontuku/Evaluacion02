
def readfile datos
	file = File.open(datos,'r')
	arreglo = file.readlines
	return arreglo
	file.close
end


#Devuelve un hash en que cada nombre es una key y las notas un array correspondiente a la key.
def parser(arr)
	names = []
	grades = []
	arr2 = []
	arr.each do |string|
		times = (arr.length+1)
		array = string.split(",")
		names << array[0]
		(1..times).each do |n|
			arr2 << array[n]
		end
		grades << arr2
		arr2 = []
	end
	return hash_maker(names,grades)
end

#Recibe arrays correspondiente a key y value y devuelve un hash.
def hash_maker(names,grades)
	hash = Hash.new
	names.each_with_index do |name, idx|
		hash[name] = clean_notes(grades[idx])
	end
	hash
end

#calcula el promedio.
def average(hash)
	av = 0
	h_promedios = Hash.new
	hash.each do |k,v|
		hash[k].each do |note|
			if !"A".include?(note)
				av += note.to_i
			end
		h_promedios[k] = av/(hash[k].length - (absent(hash)[k].to_i))
		end
		av = 0
	end
	h_promedios
end

#retorna los estudiantes que aprobaron.
def approved(hash,note = 5)
	arr = Hash.new 
	hash.each do |k,v|
		if average(hash)[k] >= note
			arr[k]= average(hash)[k]
		end
	end 
	arr
end

#calcula la cantidad de ausencias
def absent (hash)
	sum = Hash.new
	hash.each do |k,v|
		sum[k] = v.count("A")
	end
	sum
end

#Elimina el salto de linea.
def clean_notes(arr) 
	clean = []
	arr.each do |ele|
		if ele.include?("\n")
			clean << ele[1..-2]
		else
			clean << ele[1..-1]
		end
	end
	return clean
end


data = readfile("info.csv")
final_hash = parser(data)

loop do

puts '1. Generar promedio por alumno.'
puts '2. Mostrar inasistencias totales.'
puts '3. Mostrar alumnos aprobados.'
puts '4. Salir.'
puts 'Escoja una opción: '
usuario = gets.to_i

 if  usuario == 1
 	promedio = average(final_hash)
 	file = File.open("promedios.txt", "w")
 	promedio.each {|k,v| file.print "#{k} #{v} \n"}
 	file.close
 	puts "Se ha generado un archivo con los siguientes datos " + promedio.to_s
 	puts

 elsif usuario == 2
 	absent = absent(final_hash)
 	print "Inasistencias: "
 	puts
 	absent.each {|k,v| print "El estudiante #{k} tiene |#{v}|.\n"}
 	puts

 elsif usuario == 3
 	print "Ingrese la nota de aprobación: "
 	nota = gets.to_i
 	puts
 	aprobados = approved(final_hash,nota)
 	puts "Aprobados"
 	aprobados.each {|k,v| puts "Estudiante #{k} aprueba con nota |#{v}|."}
 	puts


 elsif usuario == 4
 	break

 else
 	puts "Porfavor ingrese una opción valida" + "\n"*2
 end
end

