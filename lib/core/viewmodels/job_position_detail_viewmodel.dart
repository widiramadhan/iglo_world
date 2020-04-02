import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/models/job_position.dart';
import 'package:iglo_world/core/models/job_position_detail.dart';
import 'package:iglo_world/core/services/api.dart';
import 'package:iglo_world/core/viewmodels/base_viewmodel.dart';
import 'package:iglo_world/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobPositionDetailViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  List<JobPositionDetail> jobPosition;

  Future getJobPositionDetail(String strJobId) async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    jobPosition = await _api.getJobPositionByJobId(strJobId, prefs.getString('token'));
    setState(ViewState.Idle);
  }

  showAddTask(){

  }
}