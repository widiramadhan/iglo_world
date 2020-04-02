import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:iglo_world/core/services/api.dart';
import 'package:iglo_world/core/viewmodels/base_viewmodel.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/ui/widgets/custom_toast_content_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../locator.dart';

class RegisterViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  BuildContext context;

  bool hidePass = true;
  bool hidePass2 = true;

  void changeHidePass() {
    hidePass = !hidePass;
    notifyListeners();
  }

  void changeHidePass2() {
    hidePass2 = !hidePass2;
    notifyListeners();
  }

  Future<bool> registerAccount(String strFullname, String strUsername, String strEmail, String strPhoneNumber, String strReferalCode, String strPassword, String strConfirm) async {
    if (strFullname == '' || strUsername == '' || strEmail == '' || strPhoneNumber == '' || strPassword == '' || strConfirm == '') {
      showToastWidget(IconToastWidget.fail(msg: "Please complete form"),
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
    }else if(strUsername.length < 4){
      showToastWidget(IconToastWidget.fail(msg: "Username must be more than 4 characters long"),
          context: context,
          animation: StyledToastAnimation.slideFromBottom,
          reverseAnimation: StyledToastAnimation.slideToBottom,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.fastOutSlowIn);
      return false;
    }else if(strPassword != strConfirm){
      showToastWidget(IconToastWidget.fail(msg: "Confirm Password must match with password"),
          context: context,
          animation: StyledToastAnimation.slideFromBottom,
          reverseAnimation: StyledToastAnimation.slideToBottom,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.fastOutSlowIn);
      return false;
    }else if(strPassword.length < 4){
      showToastWidget(IconToastWidget.fail(msg: "Password must be more than 4 characters long"),
          context: context,
          animation: StyledToastAnimation.slideFromBottom,
          reverseAnimation: StyledToastAnimation.slideToBottom,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.fastOutSlowIn);
      return false;
    }else if(!strEmail.contains('@') || !strEmail.contains('.')) {
      showToastWidget(IconToastWidget.fail(msg: "Email not valid"),
          context: context,
          animation: StyledToastAnimation.slideFromBottom,
          reverseAnimation: StyledToastAnimation.slideToBottom,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.fastOutSlowIn);
      return false;
    }else if(strPhoneNumber.substring(0,2) != '08'){
      showToastWidget(IconToastWidget.fail(msg: "Phone number must start 08xxxxxxxx"),
          context: context,
          animation: StyledToastAnimation.slideFromBottom,
          reverseAnimation: StyledToastAnimation.slideToBottom,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.fastOutSlowIn);
      return false;
    }else if(strPhoneNumber.length < 8 || strPhoneNumber.length > 12){
      showToastWidget(IconToastWidget.fail(msg: "Phone number must 8-12 digits"),
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
    var success = await _api.registerAccount(strFullname, strUsername, strEmail, strPhoneNumber, strReferalCode, strPassword, prefs.getString('token'));

    if (!success) {
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
