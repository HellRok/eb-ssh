#!/usr/bin/env ruby

require 'aws-sdk-ec2'

instance_id = ARGV[0]

ec2 = Aws::EC2::Resource.new(region: 'ap-southeast-2')

puts ec2.instances.find { |instance|
  instance.id == instance_id
}.data.private_ip_address
