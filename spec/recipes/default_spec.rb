require 'spec_helper'

describe 'et_shorewall::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'installs shorewall' do
    expect(chef_run).to install_package('shorewall')
  end

  it 'installs make' do
    expect(chef_run).to install_package('make')
  end

  it 'creates a default shorewall config' do
    expect(chef_run).to render_file('/etc/default/shorewall')
  end

  it 'executes shorewall_make' do
    expect(chef_run).to run_execute('shorewall_make')
  end

  %w{
    interfaces
    masq
    policy
    routestopped
    rules
    zones
  }.each do |conf_file|
    it "creates shorewall config - #{conf_file}" do
      expect(chef_run).to render_file("#{node['shorewall']['conf_dir']}/#{conf_file}")
    end
  end

  it 'enables shorewall' do
    expect(chef_run).to enable_service('shorewall')
  end

  it 'starts shorewall' do
    expect(chef_run).to start_service('shorewall')
  end
end
