require 'rubygems/nice_install/base_ext_installer'

module Gem::Installer::Nice
  class DistroGuesser
    def self.distro
      @distro ||= if !release_files.grep(/fedora/).empty?
        :fedora
      elsif !release_files.grep(/redhat/).empty?
        # Use Fedora for RHEL ATM.
        :fedora
      elsif !release_files.grep(/SuSe/).empty?
        :opensuse
      else
        :base
      end
    end

    def self.distro_ext_installer
      require "rubygems/nice_install/#{distro}_ext_installer"
      klass = Gem::Installer::Nice.const_get("#{distro.capitalize}ExtInstaller")
      klass.new if klass && klass != BaseExtInstaller
    end

    def self.version
      versions = []

      release_files.each do |file|
        /\d+/ =~ File.open(file).readline
        versions << Regexp.last_match.to_s.to_i if Regexp.last_match
      end

      versions.uniq!.first or 1
    end

    def self.release_files
      @@release_files ||=
        Dir.glob('/etc/*{_version,-release}*').select {|e| File.file? e}
    end
  end
end
