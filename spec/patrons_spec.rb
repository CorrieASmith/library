require('spec_helper')

describe(Patrons) do

  describe('.all') do
    it('is empty at first') do
      expect(Patrons.all()).to(eq([]))
    end
  end

  describe('#==') do
    it('is considered identical if two patrons are the same') do
      patron1 = Patrons.new({:id => nil, :name => 'Joe', :phone => 555-555-5555, :city => 'Miami', :zip => 12345, :age => 25, :checkout => 'A Tale of Two Cities'})
      patron2 = Patrons.new({:id => nil, :name => 'Joe', :phone => 555-555-5555, :city => 'Miami', :zip => 12345, :age => 25, :checkout => 'A Tale of Two Cities'})
      expect(patron1).to eq(patron2)
    end
  end

  describe('.find') do
    it('finds a book from its id') do
      test_patron1 = Patrons.new({:id => nil, :name => 'Joe', :phone => 555-555-5555, :city => 'Miami', :zip => 12345, :age => 25, :checkout => 'A Tale of Two Cities'})
      test_patron1.save()
      test_patron2 = Patrons.new({:id => nil, :name => 'Duke', :phone => 333-333-3333, :city => 'Denver', :zip => 12345, :age => 28, :checkout => 'Great Expectations'})
      test_patron2.save()
      expect(Patrons.find(test_patron1.id())).to eq(test_patron1)
    end
  end

  describe('#save') do
    it('saves a new patron') do
      test_patron = Patrons.new({:id => nil, :name => 'Joe', :phone => 555-555-5555, :city => 'Miami', :zip => 12345, :age => 25, :checkout => 'A Tale of Two Cities'})
      test_patron.save()
      expect(Patrons.all()).to eq([test_patron])
    end
  end

  describe('#update') do
    it("lets you update a patrons information") do
      patron = Patrons.new({:id => nil, :name => 'John Doe', :phone => "555-555-5555", :city => 'Miami', :zip => 12345, :age => 25, :checkout => 'A Tale of Two Cities'})
      patron.save()
      patron.update({:name => 'Jane Doe', :phone => "555-555-5555", :city => 'Miami', :zip => 12345, :age => 25, :checkout => 'A Tale of Two Cities'})
      expect(patron.name()).to(eq('Jane Doe'))
    end

    it("lets you add a book to a patron") do
      patron = Patrons.new({:id => nil, :name => 'John Doe', :phone => "555-555-5555", :city => 'Miami', :zip => 12345, :age => 25, :checkout => 'A Tale of Two Cities'})
      patron.save()
      bible = Books.new({:name => "The Bible", :author => "Lots of Dudes", :genre => "Religious", :publisher => "Christianity Today", :year => "2000", :quantity => 6, :id => nil})
      bible.save()
      patron.update({:name => patron.name, :phone => patron.phone, :city => patron.city, :zip => patron.zip, :age => patron.age, :checkout => patron.checkout, :books_id => [bible.id()]})
      expect(patron.checked()).to(eq([bible]))
    end
  end

  describe('#checked') do
    it("returns all of the books checked out by a patron") do
      patron = Patrons.new({:id => nil, :name => 'John Doe', :phone => "555-555-5555", :city => 'Miami', :zip => 12345, :age => 25, :checkout => 'A Tale of Two Cities'})
      patron.save()
      bible = Books.new({:name => "The Bible", :author => "Lots of Dudes", :genre => "Religious", :publisher => "Christianity Today", :year => "2000", :quantity => 6, :id => nil})
      bible.save()
      patron.update({:name => patron.name, :phone => patron.phone, :city => patron.city, :zip => patron.zip, :age => patron.age, :checkout => patron.checkout, :books_id => [bible.id()]})
      expect(patron.checked()).to(eq([bible]))
    end
  end

  describe('#delete') do
    it("deletes a patron from the database") do
      patron = Patrons.new({:name => 'Jane Doe', :phone => "555-555-5555", :city => 'Miami', :zip => 12345, :age => 25, :checkout => 'A Tale of Two Cities', :id => nil})
      patron.save()
      patron.delete()
      expect(Patrons.all()).to(eq([]))
    end
  end
end
