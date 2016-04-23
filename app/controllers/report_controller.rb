class ReportController < ApplicationController

  def list
    @reports =  Report.all
    render json: @reports, :only => [:id, :lat, :lon, :from, :note, :severity_id, :sympthom_id]
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

    @report.severity_id = report['severity']
    @report.sympthom_id = report['sympthom']

    @report.save
    puts @report
    render json: @report, :only => [:id, :label]
  end
end
