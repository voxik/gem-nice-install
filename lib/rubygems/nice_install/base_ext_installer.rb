module Gem
  class BaseExtInstaller
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
  end
end
