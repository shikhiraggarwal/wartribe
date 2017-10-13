# Be sure to restart your server when you modify this file.

# ApplicationController.renderer.defaults.merge!(
#   http_host: 'example.org',
#   https: false
# )
TROOP_CONFIG = YAML.load_file("#{Rails.root}/config/troops.yml")
