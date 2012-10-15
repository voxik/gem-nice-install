require 'rubygems/nice_install/base_ext_installer'
require 'rubygems/nice_install/fedora_ext_installer'

module Gem
  ext_installer = FedoraExtInstaller.new

  pre_install do |gem_installer|
    unless gem_installer.spec.extensions.empty?
      missing_deps = ext_installer.gem_ext_dependencies_for(gem_installer.spec.name).delete_if do |t|
        ext_installer.ext_dependency_present?(t)
      end

      unless missing_deps.empty?
        unless ext_installer.install_ext_dependencies_for(gem_installer.spec.name, missing_deps)
          raise Gem::InstallError, "Failed to install native dependencies for '#{gem_installer.spec.name}'."
        end
      end
    end
  end

end
