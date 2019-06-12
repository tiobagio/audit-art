# audit-artifactory

This wraps the [Audit](https://github.com/chef-cookbooks/audit) cookbook and interacts with Artifactory's REST API. The name of your artifact is the key for the hash of attributes.

    node['audit-artifactory']['profiles']['test-inspec']['base_url'] = 'http://ec2-13-211-219-25.ap-southeast-2.compute.amazonaws.com:8081/artifactory'
    node['audit-artifactory']['profiles']['test-inspec']['group'] = 'testgroup'
    node['audit-artifactory']['profiles']['test-inspec']['repo'] = 'inspecpoc'
    node['audit-artifactory']['profiles']['test-inspec']['version'] = '1.0.1'

Right now compliance profiles are expected to end with `.tgz`, we'll add support for `.tar.gz` and .`zip` soon.
