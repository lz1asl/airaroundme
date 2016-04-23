class ReportController < ApplicationController

  def list
    @reports =  Report.all
    render json: @reports, :only => [:id, :lat, :lon, :from, :note, :severity_id, :sympthom_id]
  end


  def search

    filter = ActiveSupport::JSON.decode request.body.string
    radius = filter['radius']
    origin = [filter['lat'], filter['lon']]
    @reports = Report.within(radius, origin: origin)

    # TODO filter by severity and sympthom

    render json: @reports, :only => [:id, :lat, :lon, :note, :severity_id, :sympthom_id]
  end


  def create
    report = ActiveSupport::JSON.decode request.body.string
    @report = Report.new(
        from: report['from'],
        note: report['note'],
        lat: report['lat'],
        lon: report['lon']
    )

    @report.severity_id = report['severity'] unless report['severity'].blank?
    @report.sympthom_id = report['sympthom'] unless report['sympthom'].blank?

    @report.save
    render json: @report, :only => [:id, :label]
  end
end
