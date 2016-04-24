class ReportController < ApplicationController


  def list
    @reports =  Report.all
    render json: @reports, :only => [:id, :lat, :lon, :from, :note, :severity_id, :sympthom_id, :reporttype]
  end


  def search

    filter = ActiveSupport::JSON.decode request.body.string
    radius = filter['radius']
    origin = [filter['lat'], filter['lon']]
    query = Report.within(radius, origin: origin)

    unless filter['types'].blank?
      query = query.where(reporttype: filter['types'].to_a)
    end

    unless filter['recent'].blank?
      numDaysBack = filter['recent'].to_i
      query = query.where(created_at: [Time.now - numDaysBack.days..Time.now])
    end

    @reports = query.all

    # TODO filter by severity, sympthoms, type
    @markers = []
    @reports.each do |report|
      title = report.note

      unless (report.sympthom_id.blank?)
        title += ', Reported: ' + Sympthom.find(report.sympthom_id).label
      end
      unless (report.severity_id.blank?)
        title += ', Severity: ' + Severity.find(report.severity_id).label
      end



      marker = { lat: report.lat, lng: report.lon, title: title, type: report.reporttype}

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
        when 'fire'
          marker[:icon] = 'firedept'
        else
          marker[:icon] = 'caution' # also catches "aridity", "hail", "pressure"
      end

      case report.severity_id
        when 1
          marker[:icon] = 'yellow'
        when 2
          marker[:icon] = 'orange'
        when 3
          marker[:icon] = 'red'
      end

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


