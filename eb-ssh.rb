#!/usr/bin/env ruby

require 'aws-sdk-ec2'

hostname = ARGV[0]
elastic_beanstalk = hostname.gsub('eb-', '')

ec2 = Aws::EC2::Resource.new(region: 'ap-southeast-2')

matches = ec2.instances.select { |i|
  eb_name = i.tags.find { |t| t.key == 'elasticbeanstalk:environment-name' }
  next unless eb_name

  # TODO: Add in status_check, not just state check
  eb_name.value.downcase == elastic_beanstalk &&
    i.state.code == 16 # running
}

# There is no guarantee (and is in fact almost certain) that you will get the
# same server as last time, so we clear out old ones to prevent the big nasty
# "WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!" message.
`ssh-keygen -R "#{hostname}"`

puts matches.map { |m| m.data.private_ip_address }.sample
