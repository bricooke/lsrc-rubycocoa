class ApplicationController < NSObject
  kvc_accessor :number_of_friends, :log

  def awakeFromNib
    self.log = ""
  end

  ib_action :make_friends do
    self.number_of_friends.to_i.times do
      fname = Faker::Name.first_name
      lname = Faker::Name.last_name
      
      self.log = "#{fname} #{lname}\n" + self.log
      
      person = ABPerson.alloc.init
      person.setValue_forProperty(fname, OSX::KABFirstNameProperty)
      person.setValue_forProperty(lname, OSX::KABLastNameProperty)
      
      ABAddressBook.sharedAddressBook.addRecord(person)
    end
    ABAddressBook.sharedAddressBook.save
  end
end
