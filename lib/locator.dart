
import 'package:get_it/get_it.dart';
import 'package:iglo_world/core/services/api.dart';
import 'package:iglo_world/core/services/authentication_service.dart';
import 'package:iglo_world/core/viewmodels/add_ticket_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/apply_job_position_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/home_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/issue_closed_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/issue_detail_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/issue_open_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/issue_progress_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/job_category_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/job_position_detail_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/job_position_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/job_recomendation_detail_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/job_recomendation_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/login_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/register_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/whatson_viewmodel.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => Api());

  locator.registerFactory(() => LoginViewModel());
  locator.registerFactory(() => RegisterViewModel());
  locator.registerFactory(() => HomeViewModel());
  locator.registerFactory(() => JobCategoryViewModel());
  locator.registerFactory(() => JobPositionViewModel());
  locator.registerFactory(() => JobPositionDetailViewModel());
  locator.registerFactory(() => JobRecomendationViewModel());
  locator.registerFactory(() => JobRecomendationDetailViewModel());
  locator.registerFactory(() => ApplyJobPositionViewModel());
  locator.registerFactory(() => AddTicketViewModel());
  locator.registerFactory(() => IssueOpenViewModel());
  locator.registerFactory(() => IssueProgressViewModel());
  locator.registerFactory(() => IssueClosedViewModel());
  locator.registerFactory(() => IssueDetailViewModel());
  locator.registerFactory(() => WhatsOnViewModel());
}
