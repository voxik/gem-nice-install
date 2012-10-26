require 'yaml'
module Gem::Installer::Nice
  class BaseExtInstaller
    include Gem::UserInteraction

    def default_ext_dependencies
      raise NotImplementedError
    end

    def gem_ext_dependencies_for gem_name
      raise NotImplementedError
    end

    def ext_dependency_present? dep_name
      raise NotImplementedError
    end

    def install_ext_dependencies_for gem_name, deps
      raise NotImplementedError
    end

    def dep_files
      raise NotImplementedError
    end

    def get_basic_deps
      load_dep_files
      @deps["basic_build_deps"]
    end

    def get_deps(gem)
      load_dep_files
      @deps["gems"][gem] || []
    end

    private

    def load_dep_files
      return @deps if defined? @deps
      @deps = dep_files.reduce({}) do |ret, file|
        ret.merge!(load_dep_file(file))
      end
    end

    def load_dep_file(file)
      base_dir = File.expand_path("../../../../data", __FILE__)
      YAML.load_file(File.join(base_dir, file))
    end

  end
end
