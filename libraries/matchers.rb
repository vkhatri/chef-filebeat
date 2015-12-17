if defined?(ChefSpec)
  ChefSpec.define_matcher(:filebeat_prospector)

  def create_filebeat_prospector(prospector)
    ChefSpec::Matchers::ResourceMatcher.new(:filebeat_prospector, :create, prospector)
  end

  def delete_filebeat_prospector(prospector)
    ChefSpec::Matchers::ResourceMatcher.new(:filebeat_prospector, :delete, prospector)
  end
end
