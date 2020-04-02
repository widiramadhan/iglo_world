

import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/services/api.dart';
import 'package:iglo_world/core/viewmodels/base_viewmodel.dart';
import 'package:iglo_world/locator.dart';
import 'package:iglo_world/ui/widgets/custom_toast_content_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplyJobPositionViewModel extends BaseViewModel {
  Api _api = locator<Api>();
  BuildContext context;

  Future<bool> applyJobPosition(String strName, String strPhoneNumber, String strEmail, String strAttachmendId, String strJobId) async {
    if (strName == '' || strPhoneNumber == '' || strEmail == '') {
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
    print(prefs.getString('attachment_id'));
    var success = await _api.applyJobPosition(strName, strPhoneNumber, strEmail, prefs.getString('attachment_id'), strJobId, prefs.getString('token'));

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

  Future<bool> uploadAttachment(String strName, String strPhoneNumber, String strEmail, String strAttachment) async {
    if (strAttachment == null || strAttachment == '' || strName == '' || strPhoneNumber == '' || strEmail == '') {
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
    var success = await _api.uploadCV(strAttachment, prefs.getString('token'));

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

  Future<bool> uploadAttachment2(String strName, String strPhoneNumber, String strEmail, File strAttachment) async {
    if (strAttachment == null || strName == '' || strPhoneNumber == '' || strEmail == '') {
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
    var success = await _api.sendCV(strAttachment, prefs.getString('token'));

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