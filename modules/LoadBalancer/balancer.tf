resource "aws_lb" "test-lb-tf" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.Lb_SG
  subnets = var.Lb_subnets
  //[var.public_subnet_id_1, var.public_subnet_id_2]
  //subnets            = [aws_subnet.public-subnet_1.id, aws_subnet.public-subnet_2.id]
   enable_deletion_protection = false

  # access_logs {
  #   bucket  = aws_s3_bucket.lb_logs.bucket
  #   prefix  = "test-lb"
  #   enabled = true
  # }

  # tags = {
  #   Environment = "production"
  # }
}

resource "aws_lb_target_group" "tf-lb-tg" {
  name     = "tf-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.Lb_Vpc_Id
  health_check {
    path = "/"
    port = 80
  }
}

resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = aws_lb.test-lb-tf.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tf-lb-tg.arn
    type             = "forward"
  }
}

# resource "aws_vpc" "main" {
#   cidr_block = "10.0.0.0/16"
# }

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = var.TG_ARN
  target_id        = var.TG_ID
  port             = 80
  depends_on = [aws_lb_target_group.tf-lb-tg]

}



output "Lb_TG_ARN" {
  value = aws_lb_target_group.tf-lb-tg.arn
}

# output "Lb_TG_ID" {
#   value = aws_instance.ec2_instance.id
# }