require 'rails_helper'

RSpec.describe 'the department index page', type: :feature do
    let!(:dep_1){ Department.create!(name: "Sales", floor: 1)}
    let!(:dep_2){ Department.create!(name: "HR", floor: 2)}
    let!(:emp_1){ dep_1.employees.create!(name: "Ant O", level: 2)}
    let!(:emp_2){ dep_1.employees.create!(name: "Tombo", level: 3)}
    let!(:emp_3){ dep_2.employees.create!(name: "Beb", level: 4)}
    let!(:emp_4){ dep_2.employees.create!(name: "Pitz", level: 5)}

    it 'displays each department name and floor' do
      visit "/departments"

      within("#dep_#{dep_1.id}") do
        expect(page).to have_content "Sales"
        expect(page).to have_content "Floor: 1"
      end

      within("#dep_#{dep_2.id}") do
        expect(page).to have_content "HR"
        expect(page).to have_content "Floor: 2"
      end
    end

    it 'displays the name of each employee belonging to a deparment under that department' do
      visit "/departments"

      within("#dep_#{dep_1.id}") do
        expect(page).to have_content "Ant O"
        expect(page).to have_content "Tombo"
      end

      within("#dep_#{dep_2.id}") do
        expect(page).to have_content "Pitz"
        expect(page).to have_content "Beb"
      end
    end
end