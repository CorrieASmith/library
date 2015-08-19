class Patrons
  attr_reader(:id, :name, :phone, :city, :zip, :age)

  define_method(:initialize) do |attributes|
    @id = attributes.fetch(:id).to_i()
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone).to_i()
    @city = attributes.fetch(:city)
    @zip = attributes.fetch(:zip).to_i()
    @age = attributes.fetch(:age).to_i()
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
      patrons.push(Patrons.new({:id => id, :name => name, :phone => phone, :city => city, :zip => zip, :age => age}))
    end
    patrons
  end

  define_method(:==) do |other|
    self.id().eql?(other.id())
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patrons (name, phone, city, zip, age) VALUES ('#{@name}',#{@phone}, '#{@city}', #{@zip}, #{@age}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end
end
