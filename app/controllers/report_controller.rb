class ReportController < ApplicationController

  def list
    @reports =  Report.all
    render json: @reports, :only => [:id, :lat, :lon, :from, :note]
  end


  def search

=begin
:origin => [37.792,-122.393]
Location.within(5, :origin => @somewhere)

@reports =  Report.findby

render json @reports, :only => [:id, :lat, :lon, :from, :note]
=end
  end


  def create
    report = ActiveSupport::JSON.decode request.body.string
    @report = Report.new(
        from: report['from'],
        note: report['note'],
        lat: report['lat'],
        lon: report['lon']
    )

    if report['severity']
        severity = Severity.find(report['severity'])
        @report.severity = severity
    end

    if report['sympthom']
      sympthom = Severity.find(report['sympthom'])
      @report.sympthom = sympthom
    end

    @report.save
    puts @report
    render json: @report, :only => [:id, :label]
  end
end
