class InSightApiConnection
  include HTTParty
    debug_output $stdout

  DEFAULT_API_VERSION = "1.0"
  DEFAULT_BASE_URI    = "https://api.nasa.gov"
  DEFAULT_QUERY       = {api_key: "DEMO_KEY", feedtype: "json", ver:"1.0"}

  base_uri DEFAULT_BASE_URI

  def initialize(options={})
    @api_version = options.fetch(:api_version, DEFAULT_API_VERSION)
    @query       = options.fetch(:query, DEFAULT_QUERY)
    @connection  = self.class
  end

  def query(params={})
    @query.update(params)
  end

  def get(relative_path, query={})
    # relative_path = add_api_version(relative_path)
    connection.get relative_path, query: @query.merge(query)
  end

  private

  attr_reader :connection

  def add_api_version(relative_path)
    "/#{api_version_path}#{relative_path}"
  end

  def api_version_path
    "v" + @api_version.to_s
  end
end
