if Gem.respond_to? :default_ext_dependencies

  Gem.pre_install do |gem_installer|
    unless gem_installer.spec.extensions.empty?
      missing_deps = Gem.gem_ext_dependencies_for(gem_installer.spec.name).delete_if do |t|
        Gem.ext_dependency_present?(t)
      end

      unless missing_deps.empty?
        unless Gem.install_ext_dependencies_for(gem_installer.spec.name, missing_deps)
          raise Gem::InstallError, "Failed to install native dependencies for '#{gem_installer.spec.name}'."
        end
      end
    end
  end

end
