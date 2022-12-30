require 'rails_helper'

RSpec.describe EmployeeTicket, type: :model do
  describe 'relationship' do
    it { should belong_to :employee }
    it { should belong_to :ticket }
  end
end