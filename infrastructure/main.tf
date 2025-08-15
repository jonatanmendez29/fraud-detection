provider "aws" {
  region = var.aws_region
}
module "networking" {
  source = "./modules/networking"
}
module "storage" {
  source = "./modules/storage"
  project_name = var.project_name
}
module "compute" {
  source = "./modules/compute"
  project_name = var.project_name
  vpc_id = module.networking.vpc_id
  private_subnet_ids = module.networking.private_subnet_ids
}