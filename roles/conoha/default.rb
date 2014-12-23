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

template 'github_ranks/.env' do
  path   '/home/k0kubun/github_ranks/shared/.env'
  source 'files/.env'
  owner  'k0kubun'
  group  'k0kubun'
  mode   '644'
end

directory '/home/k0kubun/github_ranks/shared/config' do
  owner  'k0kubun'
  group  'k0kubun'
  mode   '755'
end

template 'github_ranks/config/secrets.yml' do
  path   '/home/k0kubun/github_ranks/shared/config/secrets.yml'
  source 'files/secrets.yml'
  owner  'k0kubun'
  group  'k0kubun'
  mode   '644'
end

git '/home/k0kubun/github_ranks/shared/light_blue' do
  repository 'git@bitbucket.org:k0kubun/light_blue'
end

# workaround for assets pipeline
directory '/home/k0kubun/github_ranks/shared/fonts' do
  owner  'k0kubun'
  group  'k0kubun'
  mode   '755'
end

# workaround for assets pipeline
link '/home/k0kubun/github_ranks/shared/fonts/assets' do
  to '/home/k0kubun/github_ranks/current/light_blue/app/assets/fonts/light_blue'
end
