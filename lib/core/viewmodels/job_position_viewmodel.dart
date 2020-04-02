import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/models/job_category.dart';
import 'package:iglo_world/core/models/job_position.dart';
import 'package:iglo_world/core/services/api.dart';
import 'package:iglo_world/core/viewmodels/base_viewmodel.dart';
import 'package:iglo_world/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobPositionViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  List<JobPosition> jobPosition;
  List<JobCategory> jobCategory;

  Future getAll(String strJobCategoryId){
    getJobPosition(strJobCategoryId);
    getJobCategory();
  }

  Future getJobPosition(String strJobCategoryId) async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    jobPosition = await _api.getJobPosition(strJobCategoryId, prefs.getString('token'));
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future getJobCategory() async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    jobCategory = await _api.getJobCategory(prefs.getString('token'));
    notifyListeners();
    setState(ViewState.Idle);
  }
}