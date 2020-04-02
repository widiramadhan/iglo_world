import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/models/job_position.dart';
import 'package:iglo_world/core/models/job_position_detail.dart';
import 'package:iglo_world/core/models/job_recomendation_detail.dart';
import 'package:iglo_world/core/models/job_recomendation_history.dart';
import 'package:iglo_world/core/models/transaction_status.dart';
import 'package:iglo_world/core/services/api.dart';
import 'package:iglo_world/core/viewmodels/base_viewmodel.dart';
import 'package:iglo_world/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JobRecomendationDetailViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  List<JobRecomendationDetail> jobRecomendationDetail;
  List<TransactionStatus> transactionStatus;
  List<JobRecomendationHistory> jobRecomendationHistory;

  Future getJobRecomendationDetail(String strRecomendationId) async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    jobRecomendationDetail = await _api.getJobRecomendationById(strRecomendationId, prefs.getString('token'));
    getRecomendationHistory(strRecomendationId);
    setState(ViewState.Idle);
  }

  Future getTransactionStatus() async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    transactionStatus = await _api.getTransactionStatus(prefs.getString('token'));
    setState(ViewState.Idle);
  }

  Future getRecomendationHistory(String strRecomendationId) async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    jobRecomendationHistory = await _api.getJobRecomendationHistory(strRecomendationId, prefs.getString('token'));
    setState(ViewState.Idle);
  }
}