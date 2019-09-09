provides :coturn_server
resource_name :coturn_server

property :server_name, String, name_property: true
property :ssl_cert_path, String
property :ssl_key_path, String

action :create do
  package 'coturn' do
    action :install
  end

  file '/etc/default/coturn' do
    content "TURNSERVER_ENABLED=1\n"
    mode '0644'
    action :create
  end

  template '/etc/turnserver.conf' do
    source 'turnserver.conf.erb'
    variables(
      turn_server_name: new_resource.server_name,
      ssl_cert_path: new_resource.ssl_cert_path || node['certbot']['ssl_cert_path'],
      ssl_key_path: new_resource.ssl_key_path || node['certbot']['ssl_key_path']
    )
    cookbook 'coturn'
    action :create
    notifies :restart, 'service[coturn]', :delayed
  end

  service 'coturn' do
    action [:enable, :start]
  end
end

action :remove do
  service 'coturn' do
    action [:stop, :disable]
  end

  file '/etc/default/coturn' do
    action :delete
  end

  template '/etc/turnserver.conf' do
    action :delete
  end

  package 'coturn' do
    action :remove
  end
end
