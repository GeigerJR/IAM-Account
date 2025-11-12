resource "aws_iam_group" "group" {
  for_each = var.groups
  name     = each.key
}

resource "aws_iam_group_policy_attachment" "group_policy" {
  for_each   = var.groups
  group      = aws_iam_group.group[each.key].name
  policy_arn = each.value.policy_arn
}

resource "aws_iam_group_membership" "group_membership" {
  for_each = var.groups
  name     = "${each.key}-membership"
  users    = each.value.users
  group    = aws_iam_group.group[each.key].name
}