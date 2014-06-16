default['et_shorewall']['conf_dir'] = '/etc/shorewall'
default['et_shorewall']['log_file'] = '/var/log/messages'
default['et_shorewall']['tunnels'] = []
default['et_shorewall']['zone_conf'] = {
  'default_iface_options' => [],
  'zones' => {
    'net' => {
      'type' => 'ipv4',
      'interface' => 'eth0',
      'broadcast' => 'detect',
      'masq' => {
        'sources' => [
          '10.0.0.0/8',
          '169.254.0.0/16',
          '172.16.0.0/12',
          '192.168.0.0/16'
        ]
      }
    },
    'loc' => {
      'type' => 'ipv4',
      'interface' => 'eth1',
      'broadcast' => 'detect',
      'iface_options' => [
        'dhcp'
      ]
    },
    'fw' => {
      'type' => 'firewall'
    }
  }
}
default['et_shorewall']['policies'] = [
  {
    'source' => 'loc',
    'dest' => 'net',
    'policy' => 'ACCEPT'
  },
  {
    'source' => '$FW',
    'dest' => 'net',
    'policy' => 'ACCEPT'
  },
  {
    'source' => 'net',
    'dest' => 'all',
    'policy' => 'DROP',
    'log_level' => 'info'
  }
]
default['et_shorewall']['rules'] = [
  {
    'action' => 'ACCEPT',
    'source' => '$FW',
    'dest' => 'loc',
    'proto' => 'icmp'
  },
  {
    'action' => 'ACCEPT',
    'source' => '$FW',
    'dest' => 'net',
    'proto' => 'icmp'
  }
]
