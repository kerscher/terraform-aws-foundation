output "elasticache_url" {
    value = "${module.my-ec-cluster.redis_url}"
}
output "leader_asg_name" {
    value = "${module.cleaders.asg_name}"
}
output "worker_asg_name" {
    value = "${module.cworkers-a.asg_name}"
}
output "manage_asg_name" {
    value = "${module.management-cluster.asg_name}"
}