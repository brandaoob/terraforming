locals {
  configs = flatten([
    for filepath in fileset(path.module, "servers/*.yaml") : [
      yamldecode(file(filepath))
    ]
  ])

  servers = flatten([
    for config in local.configs : [
      for server in config.servers : {
        name = "${server.name}-${config.environment}"
        size = server.size
        type = server.type
      }
    ]
  ])
}