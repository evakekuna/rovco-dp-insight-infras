# create Redis message broker

resource "aws_elasticache_cluster" "staging-redis-001" {
    cluster_id             = "staging-redis-001"
    engine                 = "redis"
    engine_version         = "5.0.0"
    node_type              = "cache.t2.micro"
    num_cache_nodes        = 1
    parameter_group_name   = "default.redis5.0"
    port                   = 6379
    subnet_group_name      = "rovco-ddp-s-ecsn"
    security_group_ids     = ["sg-017c64e6950d48c08"]
}