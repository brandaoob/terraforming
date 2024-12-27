module "buckets" {
  source = "./bucket"

  buckets = ["documents", "images", "users"]
}

module "ec2" {
  source = "./ec2"

  for_each = { for k, v in local.servers : k => v }

  name = each.value.name
  type = each.value.type
  size = each.value.size
}