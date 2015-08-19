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
  patron = Patrons.new({:id => nil, :name => name, :phone => phone, :city => city, :zip => zip, :age => age})
  patron.save()
  redirect('/patrons')
end

get('/search') do
  @search_term = Books.all()
  erb(:index)
end

get('/patrons_edit/:id') do
  @patron = Patrons.find(params.fetch("id").to_i())
  erb(:patrons_edit)
end

get('/patrons_edit') do
  erb(:patrons_edit)
end

patch('/patrons/:id') do
  name = params.fetch("name")
  @patron = Patrons.find(params.fetch("id").to_i())
  @patron.update({:name => name})
  erb(:patrons)
end

# get('/patrons/') do
#   erb(:patrons_edit)
# end
