#!/usr/bin/ruby

if ARGV.size.zero?
  puts %Q[
    Usage:
      ./yaml_to_csv.rb file.yml > out.csv
  ]
  exit
end

require 'yaml'

def traverse(obj, keys = [], &block)
  case obj
  when Hash
    obj.each do |k,v|
      keys << k
      traverse(v, keys, &block)
      keys.pop
    end
  when Array
    obj.each { |v| traverse(v, keys, &block) }
  else
    yield keys, obj
  end
end

hash = YAML.load(File.open(ARGV.first))

puts "YAML KEY,VALUE,RECOMMENDATION"

traverse(hash) do |keys, value|
  if value =~ /^(.+)?(\/\*\s*(.+?)\s*\*\/)$/
    puts '"' + [keys * '.', $1.strip, $3.strip] * '","' + '"'
  else
    puts '"' + [keys * '.', value] * '","' + '"'
  end
end
