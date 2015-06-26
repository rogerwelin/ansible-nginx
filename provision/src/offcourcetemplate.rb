#!/opt/vagrant_ruby/bin/ruby 
# WTF is this ??? Vagrant?

require 'rubygems'
require 'erb'
require 'net/http'
require 'json'

class TemplateBinding
  attr_accessor :resources

  def initialize(hash)
    @resources = hash
  end

  def get_binding
    binding
  end
end

begin
  uri = URI('http://192.168.50.99:4001/v2/keys/webservers')
  r = Net::HTTP.get(uri)
  json_obj = JSON.parse(r)
rescue StandardError => e
  raise "Unexpected error while querying etcd: #{e}"
end

ip_arr = Array.new

json_obj['node']['nodes'].each do |element|
  ip_arr << element['value']
end

raise "No data found, exiting." if ip_arr.nil?

template  = "/tmp/default.erb"
@bind = TemplateBinding.new(ip_arr)
path = "/etc/nginx/sites-enabled/default"

begin
  t = File.read(template)
  File.open(path, 'w') { |file|
    file.write(
    ERB.new(t, nil, '-').result(@bind.get_binding)
  )}
rescue StandardError => e
  raise "Unexpected error while trying to write template: #{e}"
end




