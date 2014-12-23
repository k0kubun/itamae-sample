load_config 'conoha'

include_recipe '../shared/user.rb'
include_recipe '../shared/sudoers.rb'
include_recipe '../shared/sshd.rb'
include_recipe '../shared/iptables.rb'
include_recipe '../shared/mysql.rb'

include_cookbook 'ruby'
include_cookbook 'nginx'

template 'nginx.conf' do
  path   '/etc/nginx/nginx.conf'
  source 'files/nginx.conf'
  owner  'root'
  group  'root'
  mode   '644'
  notifies :reload, 'service[nginx]'
end

# remote_directory '/home/k0kubun/github_ranks/shared/light_blue' do
#   source 'light_blue'
#   owner  'k0kubun'
#   group  'k0kubun'
#   mode   '755'
# end
