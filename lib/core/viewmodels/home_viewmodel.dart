import 'dart:io';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/models/bank_account.dart';
import 'package:iglo_world/core/models/bod.dart';
import 'package:iglo_world/core/models/invite_friends.dart';
import 'package:iglo_world/core/models/issue_open.dart';
import 'package:iglo_world/core/models/job_position.dart';
import 'package:iglo_world/core/models/notification.dart';
import 'package:iglo_world/core/models/reward.dart';
import 'package:iglo_world/core/models/user_login.dart';
import 'package:iglo_world/core/models/whats_on.dart';
import 'package:iglo_world/core/services/api.dart';
import 'package:iglo_world/core/viewmodels/base_viewmodel.dart';
import 'package:iglo_world/locator.dart';
import 'package:iglo_world/ui/widgets/custom_toast_content_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  List<BodQuote> bod;
  List<IssueOpen> issue;
  List<UserLogin> user;
  List<BankAccount> bankAccount;
  List<WhatsOn> whatson;
  List<JobPosition> jobPosition;
  List<Notifications> notifications;
  List<InviteFriends> inviteFriends;
  List<Reward> reward;

  bool hidePass = true;
  bool hidePass2 = true;
  bool hidePass3 = true;

  void changeHidePass() {
    hidePass = !hidePass;
    notifyListeners();
  }

  void changeHidePass2() {
    hidePass2 = !hidePass2;
    notifyListeners();
  }

  void changeHidePass3() {
    hidePass3 = !hidePass3;
    notifyListeners();
  }

  BuildContext context;

  getAll() async {
    getNotificationsUnread();
    getUserLogin();
    getIssueOpen();
    getBodQuote();
    getWhatsOn();
    getJobPosition();
  }

  Future getNotifications() async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    notifications = await _api.getNotification(prefs.getString('token'));
    notifyListeners();
    getNotificationsRead();
    setState(ViewState.Idle);
  }

  Future getNotificationsRead() async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var success = await _api.getNotificationRead(prefs.getString('token'));

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
  }

  Future getNotificationsUnread() async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    notifications = await _api.getNotificationUnread(prefs.getString('token'));
    prefs.setInt('total_unread', notifications.length);
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future getJobPosition() async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    jobPosition = await _api.getJobPosition("0", prefs.getString('token'));
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future getBodQuote() async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bod = await _api.getQuote(prefs.getString('token'));
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future getWhatsOn() async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    whatson = await _api.getWhatsOn(prefs.getString('token'));
    setState(ViewState.Idle);
  }

  Future getIssueOpen() async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    issue = await _api.getIssueOpen(prefs.getString('token'));
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future getUserLogin() async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    user = await _api.getUserLogin(prefs.getString('token'));
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future<bool> updateProfile(String strFullname, String strEmail, String strPhoneNumber) async {
    if (strFullname == '' || strEmail == '' || strPhoneNumber == '') {
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
    }else if(!strEmail.contains('@') || !strEmail.contains('.')){
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
    }else if(strPhoneNumber.length < 8 && strPhoneNumber.length > 12){
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
    var success = await _api.updateProfile(strFullname, strEmail, strPhoneNumber, prefs.getString('token'));

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

  Future<bool> changePassword(String strOldPassword, String strNewPassword, String strConfirmPassword) async {
    if (strOldPassword == '' || strNewPassword == '' || strConfirmPassword == '') {
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
    }else if(strNewPassword.length < 4){
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
    }

    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var success = await _api.changePassword(prefs.getString('username'), strOldPassword, strNewPassword, strConfirmPassword, prefs.getString('token'));

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


  Future getBankAccount() async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bankAccount = await _api.getBankAcccount(prefs.getString('token'));
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future<bool> submitBankAccount(String strAccountName, String strBankName, String strAccountNumber) async {
    if (strAccountName == '' || strBankName == '' || strAccountNumber == '') {
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
    var success = await _api.submitBankAccount(strAccountName, strBankName, strAccountNumber, prefs.getString('token'));

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

  Future<bool> changeProfilePicture(File fileImage) async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var success = await _api.changeProfilePicture(fileImage, prefs.getString('token'));

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


  Future getInviteFriends() async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    inviteFriends = await _api.getInviteFriends(prefs.getString('token'));
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future getRewards() async {
    setState(ViewState.Busy);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    reward = await _api.getReward(prefs.getString('token'));
    notifyListeners();
    setState(ViewState.Idle);
  }
}

