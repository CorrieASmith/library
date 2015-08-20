require('pry')

require('sinatra')
require('sinatra/reloader')
require('./lib/books')
require('./lib/patrons')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "library"})

get('/') do
  erb(:index)
end

get('/books') do
  @books = Books.all()
  erb(:books)
end

get('/patrons') do
  @patrons = Patrons.all()
  erb(:patrons)
end

post('/books/new') do
  name = params.fetch('name')
  author = params.fetch('author')
  genre = params.fetch('genre')
  publisher = params.fetch('publisher')
  year = params.fetch('year')
  quantity = params.fetch('quantity')
  book = Books.new({:name => name, :author => author, :genre => genre, :publisher => publisher, :year => year, :quantity => quantity, :id => nil})
  book.save()
  redirect('/books')
end

post('/patrons/new') do
  name = params.fetch('name')
  phone = params.fetch('phone')
  city = params.fetch('city')
  zip = params.fetch('zip')
  age = params.fetch('age')
  patron = Patrons.new({:id => nil, :name => name, :phone => phone, :city => city, :zip => zip, :age => age, :checkout => ""})
  patron.save()
  redirect('/patrons')
end

get('/search') do
  @search_term = Books.all()
  erb(:index)
end

get('/patrons/:id') do
  @patron = Patrons.find(params.fetch("id").to_i())
  @patrons = Patrons.all()
  erb(:patrons)
end

get('/patrons_edit/:id') do
  @patron = Patrons.find(params.fetch("id").to_i())
  @patron_name = @patron.name()
  @patron_id = @patron.id()
  erb(:patrons_edit)
end

patch('/patrons/:id/name') do
  name = params.fetch('name')
  @patron = Patrons.find(params.fetch("id").to_i())
  phone = @patron.phone()
  city = @patron.city()
  zip = @patron.zip()
  age = @patron.age()
  @patron.update({:phone => phone, :name =>name, :city => city, :zip => zip, :age => age})
  @patrons = Patrons.all()
  redirect('/patrons')
end

patch('/patrons/:id/phone') do
  phone = params.fetch('phone')
  @patron = Patrons.find(params.fetch("id").to_i())
  name = @patron.name()
  city = @patron.city()
  zip = @patron.zip()
  age = @patron.age()
  @patron.update({:phone => phone, :name =>name, :city => city, :zip => zip, :age => age})
  @patrons = Patrons.all()
  redirect('/patrons')
end

patch('/patrons/:id/city') do
  city = params.fetch('city')
  @patron = Patrons.find(params.fetch("id").to_i())
  name = @patron.name()
  phone = @patron.phone()
  zip = @patron.zip()
  age = @patron.age()
  @patron.update({:phone => phone, :name =>name, :city => city, :zip => zip, :age => age})
  @patrons = Patrons.all()
  redirect('/patrons')
end

patch('/patrons/:id/zip') do
  zip = params.fetch('zip')
  @patron = Patrons.find(params.fetch("id").to_i())
  name = @patron.name()
  phone = @patron.phone()
  city = @patron.city()
  age = @patron.age()
  @patron.update({:phone => phone, :name =>name, :city => city, :zip => zip, :age => age})
  @patrons = Patrons.all()
  redirect('/patrons')
end

patch('/patrons/:id/age') do
  age = params.fetch('age')
  @patron = Patrons.find(params.fetch("id").to_i())
  name = @patron.name()
  phone = @patron.phone()
  city = @patron.city()
  zip = @patron.zip()
  @patron.update({:phone => phone, :name =>name, :city => city, :zip => zip, :age => age})
  @patrons = Patrons.all()
  redirect('/patrons')
end

get('/books/:id') do
  @book = Books.find(params.fetch("id").to_i())
  @books = Books.all()
  erb(:books)
end

get('/books_edit/:id') do
  @book = Books.find(params.fetch("id").to_i())
  @book_name = @book.name()
  @book_id = @book.id()
  erb(:books_edit)
end

patch('/books/:id/name') do
  name = params.fetch('name')
  @book = Books.find(params.fetch("id").to_i())
  author = @book.author()
  year = @book.year()
  publisher = @book.publisher()
  genre = @book.genre()
  quantity = @book.quantity()
  @book.update({:name => name, :author => author, :genre => genre, :publisher => publisher, :year => year, :quantity => quantity})
  @books = Books.all()
  redirect('/books')
end

patch('/books/:id/author') do
  author = params.fetch('author')
  @book = Books.find(params.fetch("id").to_i())
  name = @book.name()
  year = @book.year()
  publisher = @book.publisher()
  genre = @book.genre()
  quantity = @book.quantity()
  @book.update({:name => name, :author => author, :genre => genre, :publisher => publisher, :year => year, :quantity => quantity})
  @books = Books.all()
  redirect('/books')
end

patch('/books/:id/year') do
  year = params.fetch('year')
  @book = Books.find(params.fetch("id").to_i())
  name = @book.name()
  author = @book.author()
  publisher = @book.publisher()
  genre = @book.genre()
  quantity = @book.quantity()
  @book.update({:name => name, :author => author, :genre => genre, :publisher => publisher, :year => year, :quantity => quantity})
  @books = Books.all()
  redirect('/books')
end

patch('/books/:id/publisher') do
  publisher = params.fetch('publisher')
  @book = Books.find(params.fetch("id").to_i())
  name = @book.name()
  author = @book.author()
  year = @book.year()
  genre = @book.genre()
  quantity = @book.quantity()
  @book.update({:name => name, :author => author, :genre => genre, :publisher => publisher, :year => year, :quantity => quantity})
  @books = Books.all()
  redirect('/books')
end

patch('/books/:id/genre') do
  genre = params.fetch('genre')
  @book = Books.find(params.fetch("id").to_i())
  name = @book.name()
  author = @book.author()
  year = @book.year()
  publisher = @book.publisher()
  quantity = @book.quantity()
  @book.update({:name => name, :author => author, :genre => genre, :publisher => publisher, :year => year, :quantity => quantity})
  @books = Books.all()
  redirect('/books')
end

patch('/books/:id/quantity') do
  quantity = params.fetch('quantity')
  @book = Books.find(params.fetch("id").to_i())
  name = @book.name()
  author = @book.author()
  year = @book.year()
  publisher = @book.publisher()
  genre = @book.genre()
  @book.update({:name => name, :author => author, :genre => genre, :publisher => publisher, :year => year, :quantity => quantity})
  @books = Books.all()
  redirect('/books')
end

delete("/patrons/:id") do
  @patron = Patrons.find(params.fetch("id").to_i())
  @patron.delete()
  @patrons = Patrons.all()
  redirect('/patrons')
end

delete("/books/:id") do
  @book = Books.find(params.fetch("id").to_i())
  @book.delete()
  @books = Books.all()
  redirect('/books')
end
