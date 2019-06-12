name 'audit-artifactory'
maintainer 'Matt Ray'
maintainer_email 'matt@chef.io'
license 'Apache-2.0'
description 'Downloads profiles from Artifactory to use with the Audit cookbook'
long_description 'Downloads profiles from Artifactory by version or \'latest\' to use with the Audit cookbook'
version '0.2.0'
chef_version '>= 14.0' if respond_to?(:chef_version)

depends 'audit', '~> 7.6.0'

issues_url       'https://github.com/mattray/audit-artifactory-cookbook/issues'
source_url       'https://github.com/mattray/audit-artifactory-cookbook'

supports         'redhat'
supports         'centos'
