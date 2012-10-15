module Gem
  class FedoraExtInstaller < BaseExtInstaller
    def default_ext_dependencies
      %w{gcc make ruby-devel}
    end

    def gem_ext_dependencies_for gem_name
      default_ext_dependencies
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
