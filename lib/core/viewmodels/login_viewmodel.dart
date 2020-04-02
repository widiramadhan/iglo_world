import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:iglo_world/core/services/authentication_service.dart';
import 'package:iglo_world/core/utility/app_utility.dart';
import 'package:iglo_world/core/viewmodels/base_viewmodel.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/ui/widgets/custom_toast_content_widget.dart';

import '../../locator.dart';

class LoginViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  BuildContext context;

  bool hidePass = true;

  void changeHidePass() {
    hidePass = !hidePass;
    notifyListeners();
  }

  Future<bool> login(String usernameTxt, String passwordTxt) async {
    if (usernameTxt == '') {
      showToastWidget(IconToastWidget.fail(msg: "Please insert your username"),
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
    } else if (passwordTxt == '') {
      showToastWidget(IconToastWidget.fail(msg: "Please insert your password"),
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

    setState(ViewState.Busy);
    var success = await _authenticationService.login(usernameTxt, passwordTxt);

    if (!success) {
      showToastWidget(IconToastWidget.fail(msg: "Invalid username or password"),
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
