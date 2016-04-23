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

Severity.create(label: 'High')
Severity.create(label: 'Medium')
Severity.create(label: 'Low')