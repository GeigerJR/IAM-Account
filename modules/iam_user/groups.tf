resource "aws_iam_group" "group" {
  for_each = var.groups
  name     = each.key
}

locals {
  group_policy_attachments = flatten([
    for group_name, group_data in var.groups : [
      for policy_arn in group_data.policy_arns : {
        group_name = group_name
        policy_arn = policy_arn
      }
    ]
  ])
}

resource "aws_iam_group_policy_attachment" "group_policy" {
  for_each = {
    for entry in local.group_policy_attachments :
    "${entry.group_name}-${basename(entry.policy_arn)}" => entry
  }

  group      = aws_iam_group.group[each.value.group_name].name
  policy_arn = each.value.policy_arn
}

resource "aws_iam_group_membership" "group_membership" {
  for_each = var.groups

  name  = "${each.key}-membership"
  users = each.value.users
  group = aws_iam_group.group[each.key].name
}