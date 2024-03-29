resource_name :artifactory_profile

property :artifact, String, name_property: true
property :base_url, String, required: true
property :group, String, required: true
property :repo, String, required: true
property :version, String, default: 'latest'

action :install do
  require 'net/http'
  require 'uri'

  artifact = new_resource.artifact
  base_url = new_resource.base_url
  group = new_resource.group
  repo = new_resource.repo
  version = new_resource.version

  # get the version of the latest
  if version.eql?('latest')
    # uri = URI.parse(new_resource.source)

    # http = Net::HTTP.new(uri.host, uri.port)
    # http.use_ssl = uri.scheme == 'https'
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    # data = http.get(uri.request_uri)
    # uri = URI.parse(new_resource.source)

    url = "#{base_url}/api/search/latestVersion?g=#{group}&a=#{artifact}&repos=#{repo}"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)

    if uri.scheme.eql?('https')
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    version = Net::HTTP.get_response(URI.parse(url)).body
  end

  file_url = "#{base_url}/#{repo}/#{group}/#{artifact}/#{artifact}-#{version}.tgz"
  # fileurl = "#{base_url}/#{repo}/#{group}/#{artifact}/#{artifact}-#{version}.tar.gz"
  # fileurl = "#{base_url}/#{repo}/#{group}/#{artifact}/#{artifact}-#{version}.zip"

  directory "#{Chef::Config['file_cache_path']}/audit-artifactory/"

  # download the artifact
  remote_file "#{Chef::Config['file_cache_path']}/audit-artifactory/#{artifact}-#{version}.tgz" do
    source file_url
    mode '0600'
    action :create
  end

  # add the local file to the audit cookbook
  node.default['audit']['profiles'][artifact] = { 'path' => "#{Chef::Config['file_cache_path']}/audit-artifactory/#{artifact}-#{version}.tgz" }
end
