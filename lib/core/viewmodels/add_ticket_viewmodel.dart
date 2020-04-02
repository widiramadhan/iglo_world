import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/services/api.dart';
import 'package:iglo_world/core/viewmodels/base_viewmodel.dart';
import 'package:iglo_world/locator.dart';
import 'package:iglo_world/ui/widgets/custom_toast_content_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTicketViewModel extends BaseViewModel {
  Api _api = locator<Api>();
  BuildContext context;

  Future<bool> addTicket(String strIssue, String strSubject, String strDescription) async {
    if (strSubject == '' || strDescription == '') {
      //showToast("Please complete the form");
      showToastWidget(IconToastWidget.fail(msg: "Please complete the form"),
          context: context,
          animation: StyledToastAnimation.slideFromBottom,
          reverseAnimation: StyledToastAnimation.slideToBottom,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.fastOutSlowIn);
      return false;
    }

    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var success = await _api.addTicket(strIssue, strSubject, strDescription, prefs.getString('token'));

    if (!success) {
      //showToast("Error add ticket. Please contact your Administrator");
      showToastWidget(IconToastWidget.fail(msg: prefs.getString('message')),
          context: context,
          animation: StyledToastAnimation.slideFromBottom,
          reverseAnimation: StyledToastAnimation.slideToBottom,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.fastOutSlowIn);
      setState(ViewState.Idle);
      return false;
    }

    setState(ViewState.Idle);
    return success;
  }
}