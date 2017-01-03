output "backup_endpoint" {
  value = "${aws_s3_bucket.backup.id}"
}

output "backup_endpoint_id" {
  value = "${aws_s3_bucket.backup.arn}"
}

output "backup_availability_zone" {
  value = "${aws_s3_bucket.backup.hosted_zone_id}"
}

output "backup_region" {
  value = "${aws_s3_bucket.backup.region}"
}

output "backup_url" {
  value = "${aws_s3_bucket.backup.website_endpoint}"
}

output "backup_user_name" {
  value = "${aws_iam_access_key.backup.name}"
}

output "backup_user_id" {
  value = "${aws_iam_user.backup.arn}"
}

output "backup_access_policy" {
  value = "${data.template_file.iam-policy.rendered}"
}
