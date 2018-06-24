if defined?(ChefSpec)
  ChefSpec.define_matcher(:filebeat_install)
  ChefSpec.define_matcher(:filebeat_install_preview)
  ChefSpec.define_matcher(:filebeat_config)
  ChefSpec.define_matcher(:filebeat_prospector)
  ChefSpec.define_matcher(:filebeat_service)

  def create_filebeat_install_preview(install)
    ChefSpec::Matchers::ResourceMatcher.new(:filebeat_install_preview, :create, install)
  end

  def delete_filebeat_install_preview(install)
    ChefSpec::Matchers::ResourceMatcher.new(:filebeat_install_preview, :delete, install)
  end

  def create_filebeat_install(install)
    ChefSpec::Matchers::ResourceMatcher.new(:filebeat_install, :create, install)
  end

  def delete_filebeat_install(install)
    ChefSpec::Matchers::ResourceMatcher.new(:filebeat_install, :delete, install)
  end

  def create_filebeat_service(service)
    ChefSpec::Matchers::ResourceMatcher.new(:filebeat_service, :create, service)
  end

  def delete_filebeat_service(service)
    ChefSpec::Matchers::ResourceMatcher.new(:filebeat_service, :delete, service)
  end

  def create_filebeat_config(config)
    ChefSpec::Matchers::ResourceMatcher.new(:filebeat_config, :create, config)
  end

  def delete_filebeat_config(config)
    ChefSpec::Matchers::ResourceMatcher.new(:filebeat_config, :delete, config)
  end

  def create_filebeat_prospector(prospector)
    ChefSpec::Matchers::ResourceMatcher.new(:filebeat_prospector, :create, prospector)
  end

  def delete_filebeat_prospector(prospector)
    ChefSpec::Matchers::ResourceMatcher.new(:filebeat_prospector, :delete, prospector)
  end
end
