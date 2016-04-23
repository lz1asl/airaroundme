class SeverityController < ApplicationController

  def list
    @severities =  Severity.all
    render json: @severities, :only => [:id, :label]
  end
end
