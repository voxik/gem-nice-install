module Gem::Installer::Nice
  class FedoraExtInstaller < BaseExtInstaller
    begin
      require 'dbus'
    rescue LoadError
      warn "PackageKit installation require 'ruby-dbus' package to be installed."
    end

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
      install_using_packagekit deps
    end

    private

    def install_using_packagekit(names=[])
      begin
        session_bus = DBus::SessionBus.instance
        pkg_kit = session_bus.introspect("org.freedesktop.PackageKit", "/org/freedesktop/PackageKit")
        pkg_kit['org.freedesktop.PackageKit.Modify'].InstallPackageNames(0, names, 'show-confirm-install')
      rescue Error::ENOENT
        system "su -c 'yum install #{names.join(' ')}'"
      end
    end

  end
end
