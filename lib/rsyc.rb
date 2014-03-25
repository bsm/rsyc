require 'ostruct'
require 'yaml'
require 'erb'
require 'pathname'

module Rsyc

  def self.new(*args)
    Config.new(*args)
  end

  class Options < ::Hash

    def initialize(hash)
      super().update(hash)

      keys.each do |key|
        value = delete(key)
        self[key.to_s] = case value when Hash then Options.new(value) else value end
      end
    end

    def [](key)
      super key.to_s
    end

    def fetch(key)
      super key.to_s
    end

    def method_missing(name, *)
      key?(name.to_s) ? fetch(name) : super
    end

    def respond_to_missing?(name, *)
      key?(name.to_s) || super
    end

  end

  class Config < Options

    # @param [String] path configuration file path
    # @param [String] env environment name
    def initialize(path, env)
      path = Pathname.new(path.to_s).expand_path
      raise ArgumentError, "Unable to find a configuration in #{path}" unless path.exist?

      conf = YAML.load(ERB.new(path.read).result)
      raise ArgumentError, "Invalid configuration in #{path}" unless conf.is_a?(Hash)

      conf = conf[env.to_s]
      raise ArgumentError, "No configuration for '#{env}' found in #{path}" unless conf.is_a?(Hash)

      super(conf)
    end

  end
end

require 'rsyc/railtie.rb' if defined?(Rails)
