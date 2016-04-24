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

    # TODO filter by severity and sympthoms

=begin
    @hash = Gmaps4rails.build_markers(@reports) do |report, marker|
      marker.lat report.lat
      marker.lng report.lon
      marker.title report.note


      case report.severity_id
        when 1
          marker.icon = 'ylw_circle'
        when 2
          marker.icon = 'orange_circle'
        when 3
          marker.icon = 'red_diamond'
      end
    end

    render json: @hash
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

    @report.severity_id = report['severity'] unless report['severity'].blank?
    @report.sympthom_id = report['sympthom'] unless report['sympthom'].blank?

    @report.save
    render json: @report, :only => [:id, :label]
  end
end
