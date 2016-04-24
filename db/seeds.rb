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


def createReport(marker, reporttype)
  # e.g. "Cyclone Kerry : Largest-Eye 93.3 km (56 mi) on 21/2/1979
  name =  marker.xpath("locationName/text()").to_s
  value =  marker.xpath("/value/text()").to_s
  record = marker.xpath("recordCharacteristic/text()").to_s
  date =  marker.xpath("measureDate/text()").to_s
  label = name + ': ' +  record + ' ' + value + ' on ' + date
  puts label

  Report.create(
      lat: marker['lat'],
      lon: marker['lng'],
      reporttype: reporttype,
      note: label
  )
end

def importFile(file, reporttype)
  markers = Nokogiri::XML(File.open("public/sampledata/" + file)) do |config|
    config.strict.nonet
  end
  markers.xpath("//markers/marker").each do |marker|
    createReport(marker, reporttype)
  end
end

importFile("cyclone.xml", "cyclone")
importFile("rainfall.xml", "rainfall")

importFile("temperature.xml", "temperature")
importFile("tornado.xml", "tornado")
importFile("wave.xml", "wave")
importFile("wind.xml", "wind")





