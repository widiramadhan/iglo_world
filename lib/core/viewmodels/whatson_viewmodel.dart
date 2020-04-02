import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/models/job_category.dart';
import 'package:iglo_world/core/models/job_position.dart';
import 'package:iglo_world/core/models/whats_on.dart';
import 'package:iglo_world/core/services/api.dart';
import 'package:iglo_world/core/viewmodels/base_viewmodel.dart';
import 'package:iglo_world/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WhatsOnViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  List<WhatsOn> whatson;

  Future getWhatsOn() async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    whatson = await _api.getWhatsOn(prefs.getString('token'));
    setState(ViewState.Idle);
  }
}