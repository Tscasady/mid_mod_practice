require 'rails_helper'

RSpec.describe Employee, type: :model do

  let!(:dep_1){ Department.create!(name: "Sales", floor: 1)}
  let!(:emp_1){ dep_1.employees.create!(name: "Ant O", level: 2)}
  let!(:emp_2){ dep_1.employees.create!(name: "Tombo", level: 3)}
  let!(:emp_3){ dep_1.employees.create!(name: "Beb", level: 4)}
  let!(:emp_4){ dep_1.employees.create!(name: "Pitz", level: 5)}
  let!(:ticket_1){ emp_1.tickets.create!(subject: "work", age: 4)}
  let!(:ticket_2){ emp_1.tickets.create!(subject: "easy stuff", age: 2)}
  let!(:ticket_3){ emp_1.tickets.create!(subject: "confusing request", age: 6)}
  let!(:et1){ EmployeeTicket.create!(employee: emp_2, ticket: ticket_1)}
  let!(:et2){ EmployeeTicket.create!(employee: emp_3, ticket: ticket_1)}

  describe 'relationships' do
    it { should belong_to :department }
    it { should have_many :employee_tickets }
    it { should have_many(:tickets).through(:employee_tickets) }
  end

  describe '#ordered_tickets' do
    it 'returns a list of tickets ordered from youngest to oldest' do
      expect(emp_1.ordered_tickets).to eq([ticket_2, ticket_1, ticket_3])  
    end
  end

  describe '#co_workers' do
    it 'returns a list of employees working on the same tickets' do
      expect(emp_1.co_workers).to eq [emp_1, emp_2, emp_3]
    end
  end
end