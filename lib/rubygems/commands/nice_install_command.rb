require "rubygems/command"
require "rubygems/nice_install"

class Gem::Commands::NiceInstallCommand < Gem::Command
  def initialize
    super "nice_install", "A RubyGems plugin that improves gem installation user experience."
  end

  def arguments
    "GEMFILE       path to the gem file to install"
  end

  def usage
    "#{program_name} GEMFILE"
  end

  def execute
    gemfile = options[:args].shift # Gem file is the first argument

    # No gem
    unless gemfile
      raise Gem::CommandLineError,
        "Please specify a gem file on the command line (e.g. #{program_name} foo-0.1.0.gem)"
    end

    nice_installer = Gem::NiceInstall.new(gemfile)
    nice_installer.install
  end
end
