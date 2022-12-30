require 'rails_helper'

RSpec.describe 'The employee show page', type: :feature do

  let!(:dep_1){ Department.create!(name: "Sales", floor: 1)}
  let!(:dep_2){ Department.create!(name: "HR", floor: 2)}
  let!(:emp_1){ dep_1.employees.create!(name: "Ant O", level: 2)}
  let!(:emp_2){ dep_1.employees.create!(name: "Tombo", level: 3)}
  let!(:emp_3){ dep_2.employees.create!(name: "Beb", level: 4)}
  let!(:emp_4){ dep_2.employees.create!(name: "Pitz", level: 5)}
  let!(:ticket_1){ emp_1.tickets.create!(subject: "work", age: 4)}
  let!(:ticket_2){ emp_1.tickets.create!(subject: "easy stuff", age: 2)}
  let!(:ticket_3){ emp_1.tickets.create!(subject: "confusing request", age: 6)}
  let!(:ticket_4){ emp_2.tickets.create!(subject: "best ticket", age: 8)}
  let!(:ticket_5){ emp_2.tickets.create!(subject: "not displayed", age: 8)}
  let!(:et1){ EmployeeTicket.create!(employee: emp_2, ticket: ticket_1)}
  let!(:et2){ EmployeeTicket.create!(employee: emp_3, ticket: ticket_1)}

  describe 'an individual employees show page' do
    it 'displays the employees name and department' do
      visit "/employees/#{emp_1.id}"

      expect(page).to have_content "Ant O"
      expect(page).to have_content "Sales"
    end

    it 'displays a list of the employees tickets from oldest to youngest' do
      visit "/employees/#{emp_1.id}"

      expect("easy stuff").to appear_before "work"
      expect("work").to appear_before "confusing request"
      expect(page).to_not have_content "best ticket"
    end

    it 'displays the oldest ticket separately' do
      visit "/employees/#{emp_1.id}"
      
      expect(page).to have_content "Oldest Ticket: confusing request"
    end

    it 'has a form to add a ticket' do
      visit "/employees/#{emp_1.id}"
      
      expect(page.has_field?("ticket_id")).to be true
      expect(page.has_button?("Add Ticket")).to be true
    end

    it 'can display newly added tickets' do
      visit "/employees/#{emp_1.id}"
      
      fill_in :ticket_id, with: "#{ticket_4.id}"
      click_button "Add Ticket"

      expect(current_path).to eq "/employees/#{emp_1.id}"
      expect(page).to have_content "best ticket"
      expect(page).to_not have_content "not displayed"
    end

    it 'displays employees that are working on the same tickets' do
      visit "/employees/#{emp_1.id}"

      expect(page).to have_content "Tombo"
      expect(page).to have_content "Beb"
    end
  end
end