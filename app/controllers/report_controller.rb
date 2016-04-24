class ReportController < ApplicationController


  def list
    @reports =  Report.all
    render json: @reports, :only => [:id, :lat, :lon, :from, :note, :severity_id, :sympthom_id, :reporttype]
  end


  def search

    filter = ActiveSupport::JSON.decode request.body.string
    radius = filter['radius']
    origin = [filter['lat'], filter['lon']]
    @reports = Report.within(radius, origin: origin)

    # TODO filter by severity and sympthoms
    @markers = []
    @reports.each do |report|
      marker = { lat: report.lat, lng: report.lon, title: report.note}
      case report.severity_id
        when 1
          marker[:icon] = 'yellow'
        when 2
          marker[:icon] = 'orange'
        when 3
          marker[:icon] = 'red'
      end

      puts report.reporttype

      case report.reporttype
        when 'cyclone'
          marker[:icon] = 'caution'
        when 'rainfall'
          marker[:icon] = 'rainy'
        when 'temperature'
          marker[:icon] = 'sunny'
        when 'tornado'
          marker[:icon] = 'flag'
        when 'wave'
          marker[:icon] = 'water'
        when 'wind'
          marker[:icon] = 'caution'
      end
      #firedept

      @markers << marker
    end

    render json: @markers
  end


  def create

    begin
      report = ActiveSupport::JSON.decode request.body.string
      @report = Report.new(
          from: report['from'],
          note: report['note'],
          lat: report['lat'],
          lon: report['lon'],
          reporttype: 'user'
      )

      @report.severity_id = report['severity'] unless report['severity'].blank?
      @report.sympthom_id = report['sympthom'] unless report['sympthom'].blank?

      @report.save
      render json: @report, :only => [:id, :label]

    rescue => e
      puts e, e.backtrace
      render nothing: true, status: 400
    end
  end

  def handle_exception
    puts e
  end
end


