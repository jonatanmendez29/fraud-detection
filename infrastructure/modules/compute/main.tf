# MLflow Tracking Server (EC2)
resource "aws_instance" "mlflow_tracking" {
  ami           = "ami-0c55b159cbfafe1f0" # Ubuntu 22.04 LTS
  instance_type = "t3.medium"
  subnet_id     = aws_subnet.private[0].id
  vpc_security_group_ids = [aws_security_group.mlflow_sg.id]
  user_data     = file("${path.module}/user-data/mlflow-setup.sh")
}

# ECS Cluster for Model Serving
resource "aws_ecs_cluster" "model_serving" {
  name = "${var.project_name}-ecs-cluster"
}

# Security Group for MLflow
resource "aws_security_group" "mlflow_sg" {
  name_prefix = "mlflow-sg-"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}