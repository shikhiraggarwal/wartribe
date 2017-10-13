rails_env = Rails.env || 'development'
configs = YAML.load_file("#{Rails.root}/config/settings.yml")
redis_settings = configs[rails_env]["redis"]
host, port = redis_settings.split(":")
$redis = Redis.new(host: host, port: port, db: 0)
