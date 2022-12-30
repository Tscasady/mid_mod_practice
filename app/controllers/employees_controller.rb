class EmployeesController < ApplicationController
  def show
    @employee = Employee.find(params[:id])
  end

  def update
    employee = Employee.find(params[:id])
    ticket = Ticket.find(params[:ticket_id])
    EmployeeTicket.create!(employee: employee, ticket: ticket)
    redirect_to "/employees/#{employee.id}"
  end
end