node[:users].each do |user_info|
  user_name = user_info[:name]

  user user_name do
    password user_info[:password]
  end

  user user_name do
    gid 10 # wheel
  end

  directory "/home/#{user_name}" do
    mode '701' # for nginx
  end

  directory "/home/#{user_name}/.ssh" do
    owner user_name
    group user_name
    mode  '700'
  end

  file "/home/#{user_name}/.ssh/authorized_keys" do
    content user_info[:ssh_key]
    owner user_name
    group user_name
    mode  '600'
  end
end

template '/etc/sudoers' do
  source 'templates/sudoers'
  mode   '440'
  owner  'root'
  group  'root'
end
