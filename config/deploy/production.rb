server "54.199.10.238", user: "ec2-user", roles: %w{app db web}
set :ssh_options, keys: "~/.ssh/baukis2-serverkey.pem"
