# resource "kubernetes_pod" "test" {
#     metadata {
#         name = "pod-exmaple"
#     }
#     spec {
#         container {
#           image = "nginx:1.14.0"
#           name = "nginx-app"
#           port {
#             container_port = 80
#           }
#         }
#     }
# }