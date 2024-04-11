rackup './server/app/config.ru'
environment 'development'
pidfile './pid/puma.pid'
state_path './pid/puma.state'
bind 'tcp://0.0.0.0:9297'
# daemonize false