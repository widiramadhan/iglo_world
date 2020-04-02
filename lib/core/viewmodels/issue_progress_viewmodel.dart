import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/models/issue_open.dart';
import 'package:iglo_world/core/models/issue_progress.dart';
import 'package:iglo_world/core/models/job_position.dart';
import 'package:iglo_world/core/services/api.dart';
import 'package:iglo_world/core/viewmodels/base_viewmodel.dart';
import 'package:iglo_world/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IssueProgressViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  List<IssueProgress> issueProgress;

  Future getIssueProgress() async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    issueProgress = await _api.getIssueProgress(prefs.getString('token'));
    notifyListeners();
    setState(ViewState.Idle);
  }
}