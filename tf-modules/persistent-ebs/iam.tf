resource "aws_iam_instance_profile" "attach_ebs" {
    name = "${var.name}-attach-ebs-to-instance"
    roles = ["${aws_iam_role.attach_ebs.name}"]
}
#
resource "aws_iam_role" "attach_ebs" {
    name = "${var.name}-attach-ebs-to-instance"
    path = "/"
    assume_role_policy = <<END_POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
END_POLICY
}
#
resource "aws_iam_role_policy" "attach_ebs" {
    name = "attach_ebs"
    role = "${aws_iam_role.attach_ebs.id}"
    policy = <<END_POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ec2:AttachVolume",
        "ec2:DetachVolume"
      ],
      "Resource": [
        "arn:aws:ec2:${var.region}:${var.account_arn}:volume/${aws_ebs_volume.main.id}",
        "arn:aws:ec2:${var.region}:${var.account_arn}:instance/*"
      ]
    }
  ]
}
END_POLICY
}
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Sid": "TheseActionsDontSupportResourceLevelPermissions",
#      "Action": [
#        "ec2:DescribeVolumeAttribute",
#        "ec2:DescribeVolumeStatus",
#        "ec2:DescribeVolumes"
#      ],
#      "Effect": "Allow",
#      "Resource": "*"
#    },
#    {
#      "Sid": "TheseActionsSupportResourceLevelPermissions",
#      "Effect": "Allow",
#      "Action": [
#        "ec2:AttachVolume",
#        "ec2:DetachVolume"
#      ],
#      "Resource": "arn:aws:ec2:${var.region}:${var.account_arn}:volume/${aws_ebs_volume.main.id}"
#    }
#  ]
#}
#EOF
#}