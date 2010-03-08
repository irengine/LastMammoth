class ReportController < ApplicationController
  def register
    @employee = Employee.find(params[:id])
  end
end
