provides :coturn_server
resource_name :coturn_server

property :server_name, String, name_property: true

action :create do
  certbot_exec new_resource.server_name
  
  package 'coturn' do
    action :install
  end

  # file '/etc/default/coturn' do
  #   content "TURNSERVER_ENABLED=1\n"
  #   mode '0644'
  #   action :create
  # end

  template '/etc/turnserver.conf' do
    source 'turnserver.conf.erb'
    variables(
      turn_server_name: new_resource.server_name
    )
    cookbook 'coturn'
    action :create
    notifies :exec, "certbot_exec[#{new_resource.server_name}]", :before
    notifies :restart, 'service[coturn]', :delayed
  end

  service 'coturn' do
    action [:enable, :start]
  end
end
