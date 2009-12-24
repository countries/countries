countries = {}

CSV.open('countries.csv','r',';') do |row|
  row.map! {|x| x.to_s }
  countries[row[2]] = {}
  countries[row[2]]['name'] = row[0]
  countries[row[2]]['names'] = (row[1].empty? ? row[0] : row[1]).split(',').map {|x| x.strip}
  countries[row[2]]['alpha2'] = row[2]
  countries[row[2]]['alpha3'] = row[3]
  countries[row[2]]['number'] = row[4]
  countries[row[2]]['region'] = row[5]
  countries[row[2]]['subregion'] = row[6]
  countries[row[2]]['e164_country_code'] = row[8]
  countries[row[2]]['e164_national_prefix'] = row[9]
  countries[row[2]]['e164_international_prefix'] = row[7]
  countries[row[2]]['latitude'] = row[10]
  countries[row[2]]['longitude'] = row[11]
end

File.open( 'countries.yaml', 'w' ) do |out|
  YAML.dump( countries, out )
end


################

states = {}

CSV.open('states.csv','r',';') do |row|
  row.map! {|x| x.to_s }
  country, state = *row[1].split('-')
  
  states[country] ||= {}
  states[country][state] = {}
  
  states[country][state]['name'] = row[2]
  states[country][state]['names'] = row[3].empty? ? row[2] : row[3].split(',').map {|x| x.strip}
end

states.each do |k,v|
  File.open( "#{k}.yaml", 'w' ) do |out|
    YAML.dump( v, out )
  end
end