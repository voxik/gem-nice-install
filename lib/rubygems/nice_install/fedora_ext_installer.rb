module Gem
  class FedoraExtInstaller < BaseExtInstaller

    def dep_files
      %w[fedora.yml]
    end

    def default_ext_dependencies
      get_basic_deps
    end

    def gem_ext_dependencies_for gem_name
      default_ext_dependencies + get_deps(gem_name)
    end

    def ext_dependency_present? dep_name
      system("rpm -q #{dep_name} > /dev/null 2>&1")
    end

    def install_ext_dependencies_for gem_name, deps
      puts "Yum installing these native dependencies for Gem '#{gem_name}':"
      puts deps.join
      system("sudo yum install #{deps.join}")
    end
  end
end
