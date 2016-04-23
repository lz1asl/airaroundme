class ReportController < ApplicationController

  def list
    @reports =  Report.all
    render json: @reports, :only => [:id, :lat, :lon, :from, :note]
  end

  def create
    report = ActiveSupport::JSON.decode request.body.string
    puts report
    puts report['from']
    puts report[:from]
    @report = Report.new(
        from: report['from'],
        note: report['note'],
        lat: report['lat'],
        lon: report['lon']
    )

    @report.save
    puts @report
    render json: @report, :only => [:id, :label]
  end
end
