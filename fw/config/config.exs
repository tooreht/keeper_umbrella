# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Customize the firmware. Uncomment all or parts of the following
# to add files to the root filesystem or modify the firmware
# archive.

# config :nerves, :firmware,
#   rootfs_overlay: "rootfs_overlay",
#   fwup_conf: "config/fwup.conf"

# Use shoehorn to start the main application. See the shoehorn
# docs for separating out critical OTP applications such as those
# involved with firmware updates.
config :shoehorn,
  init: [:nerves_runtime, :nerves_init_gadget],
  app: Mix.Project.config()[:app]

# Add the RingLogger backend. This removes the
# default :console backend.
config :logger, backends: [RingLogger]

# Set the number of messages to hold in the circular buffer
config :logger, RingLogger, buffer_size: 100

# For WiFi, set regulatory domain to avoid restrictive default
config :nerves_network,
  regulatory_domain: "US"

config :nerves_network, :default,
  wlan0: [
    ssid: System.get_env("NERVES_NETWORK_SSID"),
    psk: System.get_env("NERVES_NETWORK_PSK"),
    key_mgmt: String.to_atom(System.get_env("NERVES_NETWORK_MGMT") || "WPA-PSK")
  ],
  eth0: [
    ipv4_address_method: :dhcp
  ]

config :nerves_init_gadget,
  ifname: "eth0",
  address_method: :dhcp,
  mdns_domain: "keeper.local",
  node_name: "keeper",
  node_host: :mdns_domain

config :nerves_firmware_ssh,
  authorized_keys: [
    File.read!(Path.join(System.user_home!, ".ssh/id_rsa.pub"))
    # File.read!(Path.join(System.user_home!, ".ssh/id_ed25519.pub"))
  ]

config :keeper_web, KeeperWeb.Endpoint,
  url: [host: "0.0.0.0"],
  http: [port: 80],
  secret_key_base: "AxV43EpSpCX4vgDwbb3Wa4dh5hUDxN+xC7jqqcZcAMx6LpgIc5rnktXi5SPSlmxT",
  root: Path.dirname(__DIR__),
  server: true,
  render_errors: [view: UiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Nerves.PubSub, adapter: Phoenix.PubSub.PG2],
  code_reloader: false

config :logger, level: :debug

config :keeper, Keeper.Repo,
  adapter: Sqlite.Ecto2,
  database: "#{Mix.env}.sqlite3"

# Import target specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
# Uncomment to use target specific configurations

import_config "#{Mix.Project.config[:target]}.exs"
