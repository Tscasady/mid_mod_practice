require 'rails_helper'

RSpec.describe Ticket, type: :model do
   describe 'relations' do
    it { should have_many :employee_tickets }
    it { should have_many(:employees).through(:employee_tickets) }
  end
end