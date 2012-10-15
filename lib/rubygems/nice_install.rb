
module Gem
  pre_install do |gem_installer|
    unless gem_installer.spec.extensions.empty?
      gem_installer.extend Gem::Installer::Nice
    end
  end


  class Installer
    module Nice
      require 'rubygems/nice_install/distro_guesser'

      def build_extensions
        super
      rescue ExtensionBuildError => e
        # Install platform dependencies and try the build again.
        super if install_platform_dependencies
        raise
      end

      def install_platform_dependencies
        if ext_installer = DistroGuesser.distro_ext_installer
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
end
