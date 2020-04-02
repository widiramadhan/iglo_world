import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/models/issue_comment.dart';
import 'package:iglo_world/core/models/issue_detail.dart';
import 'package:iglo_world/core/services/api.dart';
import 'package:iglo_world/core/viewmodels/base_viewmodel.dart';
import 'package:iglo_world/locator.dart';
import 'package:iglo_world/ui/widgets/custom_toast_content_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IssueDetailViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  List<IssueDetail> issueDetail;
  List<IssueComment> issueComment;

  BuildContext context;

  Future getAllData(String strIssueId) async {
    getIssueDetail(strIssueId);
    getIssueComment(strIssueId);
  }

  Future getIssueDetail(String strIssueId) async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    issueDetail = await _api.getIssueDetail(strIssueId, prefs.getString('token'));
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future getIssueComment(String strIssueId) async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    issueComment = await _api.getIssueComment(strIssueId, prefs.getString('token'));
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future<bool> addComment(String strIssueId, String strValue) async {
    if (strValue == '') {
      //showToast("Please insert your comment");
      showToastWidget(IconToastWidget.fail(msg: "Please insert your comment"),
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
    var success = await _api.addIssueComment(strIssueId, strValue, prefs.getString('token'));

    if (!success) {
      //showToast("Error add comment. Please contact your Administrator");
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

  Future<bool> actionNeedMoreTime(String strIssueId) async {
     setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var success = await _api.needMoreTimeIssue(strIssueId, prefs.getString('token'));
    if (!success) {
      //showToast("Error Request Need More Time. Please contact your Administrator");
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

  Future<bool> actionSolved(String strIssueId) async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var success = await _api.solvedIssue(strIssueId, prefs.getString('token'));
    if (!success) {
      //showToast("Error Solved Issue. Please contact your Administrator");
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

  Future<bool> actionClose(String strIssueId, String strAction) async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var success = await _api.closedIssue(strIssueId, strAction, prefs.getString('token'));
    if (!success) {
      //showToast("Error Closed Issue. Please contact your Administrator");
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