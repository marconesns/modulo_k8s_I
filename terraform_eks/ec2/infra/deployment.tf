# resource "kubernetes_deployment" "test" {
#   metadata {
#     name = "nginx-deploy"
#     labels = {
#       "app" = "nginx"
#     }
#   }
#   spec {
#     replicas = 2
#     selector {
#       match_labels = {
#         "app" = "nginx"
#       }
#     }
#     template {
#       metadata {
#         labels = {
#           "app" = "nginx"
#         }
#       }
#       spec {
#         container {
#           image = "nginx:1.24.0"
#           name  = "nginx"
#           port {
#             container_port = 80
#           }
#         }
#       }
#     }
#   }
# }

# resource "kubernetes_service" "LoadBalancer" {
#   metadata {
#     name = "load-balancer-nginx"
#   }
#   spec {
#     selector = {
#       app = "nginx"
#     }
#     port {
#       port = 8000
#       target_port = 80
#     }
#     type = "NodePort"
#   }
# }