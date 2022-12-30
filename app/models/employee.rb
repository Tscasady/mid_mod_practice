class Employee < ApplicationRecord
  belongs_to :department
  has_many :employee_tickets
  has_many :tickets, through: :employee_tickets

  def ordered_tickets
    self.tickets.order(:age)
  end

  def co_workers
    Employee.joins(:tickets).where(tickets: {id: self.tickets}).distinct
  end
end