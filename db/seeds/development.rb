require_relative "../../config/settings"

## Users
dev_user = User.find_or_initialize_by(
  name: "Dev",
  username: "dev",
  email: "dev@example.com"
)
dev_user.password = MSC.settings.dev_user_pass
dev_user.skip_confirmation!
dev_user.skip_password_change_notification!
dev_user.save!

# Servers
dev_server = Server.find_or_create_by!(
  name: "Our Minecraft Server",
  hostname: "minecraft.example.com"
)

# Locations
_dev_location_1 = dev_server.locations.find_or_create_by!(
  name: "Spawn",
  dimension: "overworld",
  x: 100,
  y: 72,
  z: 143
)
