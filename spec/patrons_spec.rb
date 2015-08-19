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

  describe('#save') do
    it('saves a new patron') do
      test_patron = Patrons.new({:id => nil, :name => 'Joe', :phone => 555-555-5555, :city => 'Miami', :zip => 12345, :age => 25})
      test_patron.save()
      expect(Patrons.all()).to eq([test_patron])
    end
  end
end
