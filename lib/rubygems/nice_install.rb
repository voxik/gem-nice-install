require 'rubygems/nice_install/distro_guesser'

module Gem
  ext_installer = DistroGuesser.distro_ext_installer.new

  pre_install do |gem_installer|
    unless gem_installer.spec.extensions.empty?
      gem_installer.extend Gem::Installer::Nice
    end
  end


  class Installer
    module Nice
      def build_extensions
        super
      rescue ExtensionBuildError => e
        # Install platform dependencies and try the build again.
        install_platform_dependencies
        super
      end

      def install_platform_dependencies
        ext_installer = FedoraExtInstaller.new

        missing_deps = ext_installer.gem_ext_dependencies_for(spec.name).delete_if do |t|
          ext_installer.ext_dependency_present?(t)
        end

        unless missing_deps.empty?
          unless ext_installer.install_ext_dependencies_for(spec.name, missing_deps)
            raise Gem::InstallError, "Failed to install native dependencies for '#{spec.name}'."
          end
        end
      end
    end
  end
end
