output "alb-dns" {
    description = "Address to target load balancer"
    value = module.alb.lb_dns_name
}