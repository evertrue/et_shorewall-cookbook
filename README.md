# et_shorewall cookbook

Installs & configures Shorewall for a firewall.

## Supported Platforms

* Ubuntu 12.04

## Attributes

| Key                          | Type   | Description               |
| ---------------------------- | ------ | ------------------------- |
| `['shorewall']['conf_dir']`  | string | Shorewall config dir      |
| `['shorewall']['zone_conf']` | hash   | Shorewall zone config     |
| `['shorewall']['policies']`  | array  | Shorewall policies config |
| `['shorewall']['rules']`     | array  | Shorewall rules           |

## Usage

### et_shorewall::default

Include `et_shorewall` in your node’s `run_list`:

```json
{
  "run_list": [
    "recipe[et_shorewall::default]"
  ]
}
```

## License and Authors

Author:: EverTrue, Inc. (<devops@evertrue.com>)
