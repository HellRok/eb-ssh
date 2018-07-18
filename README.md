# EB-SSH

A small ruby script to automate sshing into an elasticbeanstalk instance or an
ec2 instance.

## Installation

1. Run `bundle install`
2. Follow these instructions to setup your aws config file 
   https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html
3. Add this to your `.ssh/config` file:

  ```
  Host eb-*
    ProxyCommand bash -c "nc $(/path/to/eb-ssh.rb %h) %p"
    User ec2-user
    IdentityFile ~/.ssh/aws_key.pem

  Host i-*
    ProxyCommand bash -c "nc $(/path/to/i-ssh.rb %h) %p"
    User ec2-user
    IdentityFile ~/.ssh/aws_key.pem
  ```

4. Optionally you may want to change the `#!` line in `eb-ssh.rb` and
   `i-ssh.rb` to a specific ruby if you have many, but should be fine as the
   default for most users.
5. You're now ready to `ssh eb-name-of-beanstalk` or `ssh instance-id`!
