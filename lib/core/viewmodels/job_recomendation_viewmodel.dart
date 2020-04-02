import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/models/job_position.dart';
import 'package:iglo_world/core/models/job_recomendation.dart';
import 'package:iglo_world/core/services/api.dart';
import 'package:iglo_world/core/viewmodels/base_viewmodel.dart';
import 'package:iglo_world/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobRecomendationViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  List<JobRecomendation> jobRecomendation;

  Future getJobRecomendation() async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));
    jobRecomendation = await _api.getJobRecomendation(prefs.getString('token'));
    notifyListeners();
    setState(ViewState.Idle);
  }
}