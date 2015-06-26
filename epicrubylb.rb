#!/usr/bin/env ruby

require 'optparse'
require 'net/http'
require 'logger'

logger = Logger.new(STDOUT)
current_file = File.basename(__FILE__)

# if options undefined set to help option
if ARGV.empty?
  ARGV[0] = '-h'
end

options = {}

opt_parser = OptionParser.new do |opt|
  opt.banner = "Command-line utility for calculating even lb ngix round-robin load.

  ./#{current_file} [-n Number of requests to lb]

  Example: ./#{current_file} -n 100

  Expected output:
  node1: 50
  node2: 50
"

  opt.on("-n","--num-requests [Requests]","The total number of request sent to lb") do |req|
    options[:req] = req
  end

  opt.on("-h","--help","help") do
    puts opt_parser
    exit 1
  end
end

opt_parser.parse!

req = options[:req].to_i
logger.info("Making: #{req} requests to lb nginx")

node_hash = Hash.new(0)

start_time = Time.now

begin
  req.times do |request|
    uri = URI('http://127.0.0.1:9999')
    r = Net::HTTP.get(uri)
    node_hash[r.delete!("\n")] += 1
  end
rescue StandardError => e
  raise "Unexpected error requesting nginx lb: #{e}"
end

elapsed_time = Time.now - start_time

logger.info("Finished #{req} request in #{elapsed_time}. Results:")

node_hash.each do |k,v|
  logger.info("#{k} => #{v}")
end

logger.info("Goodbye, Enter the ninja")


