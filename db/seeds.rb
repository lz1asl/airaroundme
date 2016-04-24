# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Sympthom.create(label: 'Cough')
Sympthom.create(label: 'Shortness of breath')
Sympthom.create(label: 'Wheezing')
Sympthom.create(label: 'Sneezing')
Sympthom.create(label: 'Nasal obstruction')
Sympthom.create(label: 'Itchy eyes')
Sympthom.create(label: 'Other')

Severity.create(id: 1, label: 'Low')
Severity.create(id: 2, label: 'Medium')
Severity.create(id: 3, label: 'High')


# extreme weather points
def createReport(marker, reporttype)
  # e.g. "Cyclone Kerry : Largest-Eye 93.3 km (56 mi) on 21/2/1979
  name =  marker.xpath("locationName/text()").to_s
  value =  marker.xpath("/value/text()").to_s
  record = marker.xpath("recordCharacteristic/text()").to_s
  date =  marker.xpath("measureDate/text()").to_s
  label = 'Extreme climate : ' + name + ' has ' +  record + ' ' + value + ' on ' + date
  puts label

  Report.create(
      lat: marker['lat'],
      lon: marker['lng'],
      reporttype: reporttype,
      note: label
  )
end

def importHistoricFile(file, reporttype)
  markers = Nokogiri::XML(File.open("public/sampledata/" + file)) do |config|
    config.strict.nonet
  end
  markers.xpath("//markers/marker").each do |marker|
    createReport(marker, reporttype)
  end
end

importHistoricFile("cyclone.xml", "cyclone")
importHistoricFile("rainfall.xml", "rainfall")

importHistoricFile("temperature.xml", "temperature")
importHistoricFile("tornado.xml", "tornado")
importHistoricFile("wave.xml", "wave")
importHistoricFile("wind.xml", "wind")



# fire data
markers = Nokogiri::XML(File.open("public/sampledata/MODIS_C6_Europe_24h.kml")) do |config|
  config.strict.nonet
end
markers.xpath("//Placemarks/Placemark").each do |marker|

  # puts marker
  description =  marker.xpath("description/text()").to_s
  latlons = marker.xpath("Point/coordinates/text()").to_s.strip!.split(',')

  Report.create(
      lat: latlons[1].to_f,
      lon: latlons[0].to_f,
      reporttype: 'fire',
      note: description
  )

end
