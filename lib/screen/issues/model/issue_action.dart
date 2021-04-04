import 'issue.dart';

abstract class IssueAction {
  IssueAction(this.issue);

  final Issue issue;
}

class DeleteIssueAction extends IssueAction {
  DeleteIssueAction(Issue issue):super(issue);
}

class ChangeIssueAction extends IssueAction {
  ChangeIssueAction(Issue issue):super(issue);
}

class DetailsIssueAction extends IssueAction {
  DetailsIssueAction(Issue issue):super(issue);
}
