class Patrons
  attr_reader(:id, :name, :phone, :city, :zip, :age, :checkout)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id).to_i()
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone).to_i()
    @city = attributes.fetch(:city)
    @zip = attributes.fetch(:zip).to_i()
    @age = attributes.fetch(:age).to_i()
    @checkout = attributes.fetch(:checkout)
  end

  define_singleton_method(:all) do
    returned_patrons = DB.exec("SELECT * FROM patrons;")
    patrons = []
    returned_patrons.each() do |patron|
      id = patron.fetch('id')
      name = patron.fetch('name')
      phone = patron.fetch('phone')
      city = patron.fetch('city')
      zip = patron.fetch('zip')
      age = patron.fetch('age')
      checkout = patron.fetch('checkout')
      patrons.push(Patrons.new({:id => id, :name => name, :phone => phone, :city => city, :zip => zip, :age => age, :checkout => checkout}))
    end
    patrons
  end

  define_method(:==) do |other|
    self.id().eql?(other.id())
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name, phone, city, zip, age, checkout) VALUES ('#{@name}',#{@phone}, '#{@city}', #{@zip}, #{@age}, '#{@checkout}') RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:find) do |id|
    Patrons.all().each() do |patron|
      if patron.id() == id
        return patron
      end
    end
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    @phone = attributes.fetch(:phone, @phone)
    @city = attributes.fetch(:city, @city)
    @zip = attributes.fetch(:zip, @zip)
    @age = attributes.fetch(:age, @age)
    @checkout = attributes.fetch(:checkout, @checkout)
    @id = self.id()
    DB.exec("UPDATE patrons SET name = '#{@name}' WHERE id = #{@id};")
    DB.exec("UPDATE patrons SET phone = #{@phone} WHERE id = #{@id};")
    DB.exec("UPDATE patrons SET city = '#{@city}' WHERE id = #{@id};")
    DB.exec("UPDATE patrons SET zip = #{@zip} WHERE id = #{@id};")
    DB.exec("UPDATE patrons SET age = #{@age} WHERE id = #{@id};")
    DB.exec("UPDATE patrons SET checkout = '#{@checkout}' WHERE id = #{@id};")

    attributes.fetch(:books_id, []).each() do |book_id|
      DB.exec("INSERT INTO books_patrons (books_id, patrons_id) VALUES (#{book_id}, #{self.id()}) RETURNING id;")
    end
  end

  define_method(:checked) do
    books_patrons = []
    results = DB.exec("SELECT books_id FROM books_patrons WHERE patrons_id = #{self.id()};")
    results.each() do |result|
      book_id = result.fetch("books_id").to_i()
      books = DB.exec("SELECT * FROM books WHERE id = #{book_id};")
      name = books.first().fetch("name")
      books_patrons.push(Books.new({:name => "Book", :author => "Author", :genre => "Genre", :publisher => "Publisher", :year => 0000, :quantity => 2, :id => book_id}))
    end
    books_patrons
  end

  define_method(:delete) do
    DB.exec("DELETE FROM patrons WHERE id = #{self.id()};")
  end

  # got patron id from calling <patron obj>.checked out
  # pass book to check out
  # define_method(:checked_out) do |some_book|
  #   patron_id = self.id
  #   book_id = some_book.id
  #
  #   self.@checked_out.push(book_id)
  #   #save
  #
  #   #some_book.quantity -=1
  #
  #   #DB.exec("INSERT INTO books_patrons (patron_id, book_id) VALUE (#{patron_id}, #{book_id});")
  # end
end
