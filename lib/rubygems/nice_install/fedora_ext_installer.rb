module Gem::Installer::Nice
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
      install_using_packagekit(deps) \
        || install_using_dnf(deps) \
        || install_using_yum(deps)
    end

    private

    def install_using_dnf(names=[])
      if system("dnf --help > /dev/null 2>&1")
        system "su -c 'dnf install #{names.join(' ')}'"
      else
        say "DNF is not available."
        false
      end
    end

    def install_using_yum(names=[])
      if system("yum --help > /dev/null 2>&1")
        system "su -c 'yum install #{names.join(' ')}'"
      else
        say "YUM is not available."
        false
      end
    end

    def install_using_packagekit(names=[])
      begin
        require 'dbus'
        session_bus = DBus::SessionBus.instance
        pkg_kit = session_bus.introspect("org.freedesktop.PackageKit", "/org/freedesktop/PackageKit")
        pkg_kit['org.freedesktop.PackageKit.Modify'].InstallPackageNames(0, names, 'show-confirm-install')
      # DBus is not availabe in non-X environment.
      rescue Errno::ENOENT
        say "PackageKit failed. DBus activation failed."
        false
      rescue LoadError
        say "PackageKit failed. 'rubygem-ruby-dbus' package needs to be installed."
        false
      else
        true
      end
    end

  end
end
