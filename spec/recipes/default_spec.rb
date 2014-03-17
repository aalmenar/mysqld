require_relative '../spec_helper'

describe 'mysqld::default' do
  let(:rhel) { ChefSpec::Runner.new(platform: 'centos', version: '6.5', step_into: ['default']).converge(described_recipe) }
  let(:debian) { ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04', step_into: ['default']).converge(described_recipe) }

  it 'should use the correct mysql server package' do
    expect(rhel.node['mysqld']['packages']).to eq(['mysql-server'])
    expect(debian.node['mysqld']['packages']).to eq(['mysql-server'])
  end

  it 'should use distribution specific my.cnf path' do
    expect(rhel.node['mysqld']['my.cnf_path']).to eq('/etc/my.cnf')
    expect(debian.node['mysqld']['my.cnf_path']).to eq('/etc/mysql/my.cnf')
  end

  it 'shoudl use distribution specific service name' do
    expect(rhel.node['mysqld']['service_name']).to eq('mysqld')
    expect(debian.node['mysqld']['service_name']).to eq('mysql')
  end

  it 'should run mysqld_default provider' do
    expect(rhel).to create_mysqld
    expect(debian).to create_mysqld
  end
end
