# You should update the below variables

# aws_region from the core-infra example
aws_region      = "eu-west-1"


#The AWS Secrets Manager secret name containing the plaintext Github access token
github_token_secret_name = "prod/nsp/ecs" #"917d2d7cc9d71581cb8f56d8e23450b1" #"ecs-github-token"
repository_owner         = "Karolchlasta"

# It is optional to change the below variables
# core_stack_name is also same as ecs_cluster_name from core-infra
core_stack_name      = "ecs-nsp-infra"
service_name         = "nsp-server"
namespace            = "default"
backend_svc_endpoint = "http://ecsdemo-nodejs.default.ecs-nsp-infra.local:3000"
desired_count        = 3
task_cpu             = 1024 #256
task_memory          = 8192 #512 
container_name       = "ecs-nsp-server"

#Don't change the container port as it is specific to this app example

container_port = 3000

cp_strategy_fg_weight = 1
cp_strategy_fg_spot_weight = 1

# To set scheduled autoscaling, it will trigger scale up at 10 min past the hr and scale down at 20 min past the hr
enable_scheduled_autoscaling = true
scheduled_autoscaling_up_time = "cron(0 10 * ? * *)"
scheduled_autoscaling_down_time = "cron(0 20 * ? * *)"
