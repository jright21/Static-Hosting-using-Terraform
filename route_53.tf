# Create Route 53 Zone
resource "aws_route53_zone" "my_domain" {
  name = var.DOMAIN_NAME
}

# Request ACM Certificate
resource "aws_acm_certificate" "my_certificate" {
  domain_name       = var.DOMAIN_NAME
  validation_method = "DNS"

  subject_alternative_names = [var.WWW_DOMAIN_NAME]
}

# Create DNS Records for Certificate Validation
resource "aws_route53_record" "cert_validation" {
  for_each = {
    for dvo in aws_acm_certificate.my_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  zone_id = aws_route53_zone.my_domain.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 300
  records = [each.value.record]
}

# Validate ACM Certificate
resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.my_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

# DNS Record for Root Domain
resource "aws_route53_record" "domain_record_A_1" {
  zone_id = aws_route53_zone.my_domain.zone_id
  name    = var.DOMAIN_NAME
  type    = "A"
  alias {
    name                   = replace(aws_cloudfront_distribution.s3_distribution.domain_name, "/[.]$/", "")
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}

# DNS Record for WWW Subdomain
resource "aws_route53_record" "domain_record_A_2" {
  zone_id = aws_route53_zone.my_domain.zone_id
  name    = var.WWW_DOMAIN_NAME
  type    = "A"
  alias {
    name                   = replace(aws_cloudfront_distribution.s3_distribution.domain_name, "/[.]$/", "")
    zone_id                = aws_cloudfront_distribution.s3_distribution.hosted_zone_id
    evaluate_target_health = true
  }
}
