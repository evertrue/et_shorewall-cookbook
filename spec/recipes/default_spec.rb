require 'spec_helper'

describe 'et_shorewall::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      node.set['et_shorewall']['conf_dir'] = '/etc/shorewall'
    end.converge(described_recipe)
  end

  it 'installs shorewall' do
    expect(chef_run).to install_package('shorewall')
  end

  it 'installs make' do
    expect(chef_run).to install_package('make')
  end

  it 'creates a default shorewall config' do
    expect(chef_run).to render_file('/etc/default/shorewall')
  end

  it 'does not execute shorewall_make' do
    expect(chef_run).to_not run_execute('shorewall_make')
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
      expect(chef_run).to render_file("#{chef_run.node['et_shorewall']['conf_dir']}/#{conf_file}")
    end

    it 'notifies execute shorewall_make' do
      expect(chef_run.template("#{chef_run.node['et_shorewall']['conf_dir']}/#{conf_file}"))
        .to notify('execute[shorewall_make]').to(:run)
    end
  end

  it 'enables shorewall' do
    expect(chef_run).to enable_service('shorewall')
  end

  it 'starts shorewall' do
    expect(chef_run).to start_service('shorewall')
  end
end
