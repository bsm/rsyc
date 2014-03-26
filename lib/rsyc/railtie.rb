require "rails"
require "rsyc"

module Rsyc
  class Railtie < Rails::Railtie
    config.before_configuration do
      config.app = Rsyc.new Rails.root.join('config', 'app.yml'), Rails.env
    end
  end
end
