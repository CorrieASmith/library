require('spec_helper')

describe(Patrons) do

  describe('.all') do
    it('is empty at first') do
      expect(Patrons.all()).to(eq([]))
    end
  end

  describe('#==') do
    it('is considered identical if two patrons are the same') do
      patron1 = Patrons.new({:id => nil, :name => 'Joe', :phone => 555-555-5555, :city => 'Miami', :zip => 12345, :age => 25})
      patron2 = Patrons.new({:id => nil, :name => 'Joe', :phone => 555-555-5555, :city => 'Miami', :zip => 12345, :age => 25})
      expect(patron1).to eq(patron2)
    end
  end

  describe('.find') do
    it('finds a book from its id') do
      test_patron1 = Patrons.new({:id => nil, :name => 'Joe', :phone => 555-555-5555, :city => 'Miami', :zip => 12345, :age => 25})
      test_patron1.save()
      test_patron2 = Patrons.new({:id => nil, :name => 'Duke', :phone => 333-333-3333, :city => 'Denver', :zip => 12345, :age => 28})
      test_patron2.save()
      expect(Patrons.find(test_patron1.id())).to eq(test_patron1)
    end
  end

  describe('#save') do
    it('saves a new patron') do
      test_patron = Patrons.new({:id => nil, :name => 'Joe', :phone => 555-555-5555, :city => 'Miami', :zip => 12345, :age => 25})
      test_patron.save()
      expect(Patrons.all()).to eq([test_patron])
    end
  end

  describe('#update') do
    it("lets you update a patrons information") do
      patron = Patrons.new({:id => nil, :name => 'John Doe', :phone => "555-555-5555", :city => 'Miami', :zip => 12345, :age => 25})
      patron.save()
      patron.update({:name => 'Jane Doe'})
      expect(patron.name()).to(eq('Jane Doe'))
    end
  end
end
