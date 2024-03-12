resource "aws_lb" "elb-webLB" {
  name                       = "${var.default_name}-elb-webLB"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.AllowSSHandWeb.id]
  subnets                    = [aws_subnet.Public["Public1"].id, aws_subnet.Public["Public2"].id]
  
  enable_deletion_protection = false
  tags = merge(local.default_tags, {Name = "${var.default_name}-elb-webLB"})
}

resource "aws_lb_target_group" "EC2TargetGroup" {
  name        = "EC2TargetGroup"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.testVPC.id

  depends_on = [
    aws_lb.elb-webLB
  ]

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "80"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
  }
  target_health_state {
    enable_unhealthy_connection_termination = false
  }
  tags = merge(local.default_tags, {Name = "${var.default_name}-EC2TargetGroup"})
}

resource "aws_lb_target_group_attachment" "lb-attachment" {
  count = 2
  target_group_arn = aws_lb_target_group.EC2TargetGroup.arn
  target_id        = aws_instance.Server[count.index].id
  port             = 80
}

# Listener rule for HTTP traffic on each of the ALBs
resource "aws_lb_listener" "lb_listener_http" {
  load_balancer_arn = aws_lb.elb-webLB.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.EC2TargetGroup.arn
    type             = "forward"
  }
  tags = merge(local.default_tags, {Name = "${var.default_name}-lb_listener_http"})
}