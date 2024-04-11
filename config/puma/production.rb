rackup './server/app/config.ru'
environment 'production'
pidfile './pid/puma.pid'
state_path './pid/puma.state'
bind 'tcp://localhost:9297'
stdout_redirect './logs/stdout.log', './logs/stderr.log', true