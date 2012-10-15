Gem.pre_install do |gem_installer|
  unless gem_installer.spec.extensions.empty?
    have_tools = %w{gcc make sh}.all? do |t|
      system("#{t} --version > NUL 2>&1")
    end

    unless have_tools
      raise Gem::InstallError,<<-EOT
                           The '#{gem_installer.spec.name}' native gem requires installed build tools.
      EOT
    end
  end
end
