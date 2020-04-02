import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:http/http.dart' as http;
import 'package:iglo_world/core/models/bank_account.dart';
import 'package:iglo_world/core/models/bod.dart';
import 'package:iglo_world/core/models/invite_friends.dart';
import 'package:iglo_world/core/models/issue_closed.dart';
import 'package:iglo_world/core/models/issue_comment.dart';
import 'package:iglo_world/core/models/issue_detail.dart';
import 'package:iglo_world/core/models/issue_open.dart';
import 'package:iglo_world/core/models/issue_progress.dart';
import 'package:iglo_world/core/models/job_category.dart';
import 'package:iglo_world/core/models/job_position.dart';
import 'package:iglo_world/core/models/job_position_detail.dart';
import 'package:iglo_world/core/models/job_recomendation.dart';
import 'package:iglo_world/core/models/job_recomendation_detail.dart';
import 'package:iglo_world/core/models/job_recomendation_history.dart';
import 'package:iglo_world/core/models/notification.dart';
import 'package:iglo_world/core/models/reward.dart';
import 'package:iglo_world/core/models/transaction_status.dart';
import 'package:iglo_world/core/models/user.dart';
import 'package:iglo_world/core/models/user_login.dart';
import 'package:iglo_world/core/models/whats_on.dart';
import 'package:iglo_world/ui/views/login_view.dart';
import 'package:iglo_world/ui/widgets/custom_toast_content_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api extends ChangeNotifier {
  //static const endpoint = 'http://34.87.29.151:5010/api';
  //static const endpoint = 'http://10.100.10.32:5010/api';
  static const endpoint = 'http://35.247.172.93:8084/api';
  BuildContext context;
  var client = http.Client();
  static const _timeout = 30;


  void sessionExpired() async {
    await showToastWidget(IconToastWidget.fail(msg: "Your session has expired, please logout and login again"),
        context: context,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.slideToBottom,
        position: StyledToastPosition.center,
        animDuration: Duration(seconds: 1),
        duration: Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.fastOutSlowIn);
  }

  void errorRequestWithResponseCode(String responseCode) async {
    await showToastWidget(IconToastWidget.fail(msg: "Error occured while Communication with Server with StatusCode "+responseCode),
        context: context,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.slideToBottom,
        position: StyledToastPosition.center,
        animDuration: Duration(seconds: 1),
        duration: Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.fastOutSlowIn);
  }

  void errorCatch(String e) async {
    await showToastWidget(IconToastWidget.fail(msg: e),
        context: context,
        animation: StyledToastAnimation.slideFromBottom,
        reverseAnimation: StyledToastAnimation.slideToBottom,
        position: StyledToastPosition.center,
        animDuration: Duration(seconds: 1),
        duration: Duration(seconds: 4),
        curve: Curves.elasticOut,
        reverseCurve: Curves.fastOutSlowIn);
  }

  

  Future<User> fetchLogin(String username, String password) async {
    final response = await client.post('$endpoint/User/Login',
        headers: {
          "Content-Type": "application/json"
        }, body: json.encode({"username": username, "password": password})).timeout(const Duration (seconds:5));
    if (response.statusCode == 200) {
      if (json.decode(response.body)['status']['loginStatus'] == true) {
        return User.fromJson(json.decode(response.body)['data']);
      } else {
        return User.fromJson(json.decode(response.body));
      }
    } else {
      showToastWidget(IconToastWidget.fail(msg: "Failed to login. Error code "+response.statusCode.toString()),
          context: context,
          animation: StyledToastAnimation.slideFromBottom,
          reverseAnimation: StyledToastAnimation.slideToBottom,
          position: StyledToastPosition.center,
          animDuration: Duration(seconds: 1),
          duration: Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.fastOutSlowIn);
    }
    
  }

  Future<List<JobCategory>> getJobCategory(String strToken) async {
    try{
      final response = await client.get('$endpoint/JobCategory/GetListCategory',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        notifyListeners();
        Iterable jobCategory = json.decode(response.body)['data'];
        List<JobCategory> listJobCategory =
        jobCategory.map((map) => JobCategory.fromJson(map)).toList();
        return listJobCategory;
      }else if(response.statusCode == 401 || response.statusCode == 403){
        sessionExpired();
      }else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e) {
      errorCatch(e.toString());
    }
  }

  Future<List<JobPosition>> getJobPosition(String strJobCategoryId, String strToken) async {
    try{
      final response = await client.get('$endpoint/JobVacancy/GetList/'+strJobCategoryId,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        notifyListeners();
        Iterable jobPosition = json.decode(response.body)['data'];
        List<JobPosition> listJobPosition =
        jobPosition.map((map) => JobPosition.fromJson(map)).toList();
        return listJobPosition;
      } else if(response.statusCode == 401 || response.statusCode == 403){
        sessionExpired();
      }else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<List<JobPositionDetail>> getJobPositionByJobId(String strJobId, String strToken) async {
    try {
      final response = await client.get(
        '$endpoint/JobVacancyDetail/GetList/' + strJobId,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer " + strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        Iterable jobPositionDetail = json.decode(response.body)['data'];
        List<JobPositionDetail> listJobPositionDetail =
        jobPositionDetail.map((map) => JobPositionDetail.fromJson(map))
            .toList();
        notifyListeners();
        return listJobPositionDetail;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        sessionExpired();
      } else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<List<JobRecomendation>> getJobRecomendation(String strToken) async {
    try {
      final response = await client.get('$endpoint/Recommendation/GetList',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer " + strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        notifyListeners();
        Iterable jobRecomendation = json.decode(response.body)['data'];
        List<JobRecomendation> listJobRecomendation =
        jobRecomendation.map((map) => JobRecomendation.fromJson(map)).toList();
        return listJobRecomendation;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        sessionExpired();
      } else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<List<JobRecomendationDetail>> getJobRecomendationById(String strRecomendationId, String strToken) async {
    try {
      final response = await client.get(
        '$endpoint/RecommendationDetail/GetListDetail/' + strRecomendationId,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer " + strToken
        },
      ).timeout(const Duration (seconds: _timeout));
      if (response.statusCode == 200) {
        Iterable jobRecomendationDetail = json.decode(response.body)['data'];
        List<JobRecomendationDetail> listJobRecomendationDetail =
        jobRecomendationDetail.map((map) =>
            JobRecomendationDetail.fromJson(map)).toList();
        notifyListeners();
        return listJobRecomendationDetail;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        sessionExpired();
      } else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<List<TransactionStatus>> getTransactionStatus(String strToken) async {
    try {
      final response = await client.get('$endpoint/TransactionStatus/GetList',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer " + strToken
        },
      ).timeout(const Duration (seconds: _timeout));
      if (response.statusCode == 200) {
        Iterable transactionStatus = json.decode(response.body)['data'];
        List<TransactionStatus> listTransactionStatus =
        transactionStatus.map((map) => TransactionStatus.fromJson(map))
            .toList();
        notifyListeners();
        return listTransactionStatus;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        sessionExpired();
      } else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<List<JobRecomendationHistory>> getJobRecomendationHistory(String strRecomendationId, String strToken) async {
    try{
      final response = await client.get('$endpoint/RecommendationDetail/GetListDetail/'+strRecomendationId,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        Iterable jobRecomendationHistory = json.decode(response.body)['history'];
        List<JobRecomendationHistory> listJobRecomendationHistory =
        jobRecomendationHistory.map((map) => JobRecomendationHistory.fromJson(map)).toList();
        notifyListeners();
        return listJobRecomendationHistory;
      } else if(response.statusCode == 401 || response.statusCode == 403){
        sessionExpired();
      }else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<bool> applyJobPosition(String strName, String strPhoneNumber, String strEmail, String strAttachmendId, String strJobId, String strToken) async {
    try{
      final response = await client.post('$endpoint/MemberRequest/AddMember',
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $strToken"
          },
          body: json.encode({
            "Name": "$strName",
            "PhoneNumber": "$strPhoneNumber",
            "Email": "$strEmail",
            "AttachmentID": strAttachmendId,
            "JobVacancyID": strJobId
          })
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        if (json.decode(response.body)['isSuccess'] == true) {
          return true;
        } else {
          String message = json.decode(response.body)['message'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', message);
          return false;
        }
      } else {
        String message = "Error occured while Communication with Server with StatusCode "+response.statusCode.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('message', message);
        return false;
      }
    }catch(e){
      String message = "Error : "+e;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('message', message);
      return false;
    }
  }

  Future<bool> uploadCV(String strAttachment, String strToken) async {
    try{
      final response = await client.post('$endpoint/MemberRequest/UploadBase64Pdf',
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $strToken"
          },
          body: json.encode({
            "Base64Data": "$strAttachment"
          })
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        if (json.decode(response.body)['isSuccess'] == true) {
          String attachmentID = json.decode(response.body)['attachmentId'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('attachment_id', attachmentID);
          return true;
        } else {
          String message = json.decode(response.body)['message'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', message);
          return false;
        }
      } else {
        String message = "Error occured while Communication with Server with StatusCode "+response.statusCode.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('message', message);
        return false;
      }
    }catch(e){
      String message = "Error : "+e;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('message', message);
      return false;
    }
  }

  Future<bool> sendCV(File file, String strToken) async {
    try{
      String fileName = file.path.split('/').last;

      FormData data = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });

      Response response;
      var headers = {
        "Content-Type": "multipart/form-data",
        "Authorization": "Bearer ${strToken}",
      };

      Dio dio = new Dio();
      response = await dio.post('$endpoint/MemberRequest/Upload',
          data: data,
          options: Options(
            headers: headers,
          )).timeout(const Duration (seconds:_timeout));

      if(response.statusCode == 200){
        if(response.data['isSuccess'] == true) {
          if(response.data['attachmentId'] != null) {
            String attachmentID = response.data['attachmentId'].toString();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('attachment_id', attachmentID);
            return true;
          }else{
            String message = json.decode(response.data)['message'].toString();
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('message', message);
            return false;
          }
        }else{
          String message = json.decode(response.data)['message'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', message);
          return false;
        }
      }else{
        String message = "Error occured while Communication with Server with StatusCode "+response.statusCode.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('message', message);
        return false;
      }
    }catch(e){
      String message = "Error : "+e;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('message', message);
      return false;
    }
  }

  Future<bool> addTicket(String strIssue, String strSubject, String strDescription, String strToken) async {
    try{
      final response = await client.post('$endpoint/Ticket/AddTicket',
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $strToken"
          },
          body: json.encode({
            //"IssueId": "$strIssue",
            "Subject": "$strSubject",
            "Description": "$strDescription"
          })
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        if (json.decode(response.body)['isSuccess'] == true) {
          return true;
        } else {
          String message = json.decode(response.body)['message'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', message);
          return false;
        }
      } else {
        String message = "Error occured while Communication with Server with StatusCode "+response.statusCode.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('message', message);
        return false;
      }
    }catch(e){
      String message = "Error : "+e;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('message', message);
      return false;
    }
  }

  Future<List<IssueOpen>> getIssueOpen(String strToken) async {
    try{
      final response = await client.get('$endpoint/Ticket/GetListNewTicket',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        Iterable issueOpen = json.decode(response.body)['data'];
        List<IssueOpen> listIssueOpen =
        issueOpen.map((map) => IssueOpen.fromJson(map)).toList();
        notifyListeners();
        return listIssueOpen;
      } else if(response.statusCode == 401 || response.statusCode == 403){
        sessionExpired();
      }else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<List<IssueProgress>> getIssueProgress(String strToken) async {
    try{
      final response = await client.get('$endpoint/Ticket/GetProcessedListTicket',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        Iterable issue = json.decode(response.body)['data'];
        List<IssueProgress> listIssue =
        issue.map((map) => IssueProgress.fromJson(map)).toList();
        notifyListeners();
        return listIssue;
      } else if(response.statusCode == 401 || response.statusCode == 403){
        sessionExpired();
      }else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<List<IssueClosed>> getIssueClosed(String strToken) async {
    try{
      final response = await client.get('$endpoint/Ticket/GetListClosedTicketCreatedUser',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        Iterable issue = json.decode(response.body)['data'];
        List<IssueClosed> listIssue =
        issue.map((map) => IssueClosed.fromJson(map)).toList();
        notifyListeners();
        return listIssue;
      } else if(response.statusCode == 401 || response.statusCode == 403){
        sessionExpired();
      }else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<List<IssueComment>> getDetailIssue(String strIssueId, String strToken) async {
    try{
      final response = await client.get('$endpoint/Ticket/GetListRepliesTicket/'+strIssueId,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        Iterable comment = json.decode(response.body)['data'];
        List<IssueComment> listComment =
        comment.map((map) => IssueComment.fromJson(map)).toList();
        notifyListeners();
        return listComment;
      }else if(response.statusCode == 401 || response.statusCode == 403){
        sessionExpired();
      }else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<List<IssueComment>> getIssueComment(String strIssueId, String strToken) async {
    try{
      final response = await client.get('$endpoint/Ticket/GetListRepliesTicket/'+strIssueId,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        Iterable comment = json.decode(response.body)['data'];
        List<IssueComment> listComment =
        comment.map((map) => IssueComment.fromJson(map)).toList();
        notifyListeners();
        return listComment;
      }else if(response.statusCode == 401 || response.statusCode == 403){
        sessionExpired();
      }else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<List<IssueDetail>> getIssueDetail(String strIssueId, String strToken) async {
    try{
      final response = await client.get('$endpoint/Ticket/GetTicket/'+strIssueId,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        Iterable detail = json.decode(response.body)['data'];
        List<IssueDetail> listDetail =
        detail.map((map) => IssueDetail.fromJson(map)).toList();
        notifyListeners();
        return listDetail;
      }else if(response.statusCode == 401 || response.statusCode == 403){
        sessionExpired();
      }else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<bool> addIssueComment(String strIssueId, String strCommentValue, String strToken) async {
    try{
      final response = await client.post('$endpoint/Ticket/AddComment',
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $strToken"
          },
          body: json.encode({
            "IDTicket": "$strIssueId",
            "CommentText": "$strCommentValue"
          })
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        if (json.decode(response.body)['isSuccess'] == true) {
          return true;
        } else {
          String message = json.decode(response.body)['message'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', message);
          return false;
        }
      } else {
        String message = "Error occured while Communication with Server with StatusCode "+response.statusCode.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('message', message);
        return false;
      }
    }catch(e){
      String message = "Error : "+e;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('message', message);
      return false;
    }
  }

  Future<bool> needMoreTimeIssue(String strIssueId, String strToken) async {
    try{
      final response = await client.get('$endpoint/Ticket/NeedMoreTime/'+strIssueId,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $strToken"
          }
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        if (json.decode(response.body)['isSuccess'] == true) {
          return true;
        } else {
          String message = json.decode(response.body)['message'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', message);
          return false;
        }
      } else {
        String message = "Error occured while Communication with Server with StatusCode "+response.statusCode.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('message', message);
        return false;
      }
    }catch(e){
      String message = "Error : "+e;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('message', message);
      return false;
    }
  }

  Future<bool> solvedIssue(String strIssueId, String strToken) async {
    try{
      final response = await client.get('$endpoint/Ticket/SolvedTicket/'+strIssueId,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $strToken"
          }
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        if (json.decode(response.body)['isSuccess'] == true) {
          return true;
        } else {
          String message = json.decode(response.body)['message'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', message);
          return false;
        }
      } else {
        String message = "Error occured while Communication with Server with StatusCode "+response.statusCode.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('message', message);
        return false;
      }
    }catch(e){
      String message = "Error : "+e;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('message', message);
      return false;
    }
  }

  Future<bool> closedIssue(String strIssueId, String strAction, String strToken) async {
    try{
      final response = await client.post('$endpoint/Ticket/CloseTicket',
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $strToken"
          },
          body: json.encode({
            "ID": "$strIssueId",
            "Action": "$strAction"
          })
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        if (json.decode(response.body)['isSuccess'] == true) {
          return true;
        } else {
          String message = json.decode(response.body)['message'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', message);
          return false;
        }
      } else {
        String message = "Error occured while Communication with Server with StatusCode "+response.statusCode.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('message', message);
        return false;
      }
    }catch(e){
      String message = "Error : "+e;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('message', message);
      return false;
    }
  }

  Future<List<BodQuote>> getQuote(String strToken) async {
    try{
      final response = await client.get('$endpoint/Quote/GetActiveQuotes',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        Iterable quote = json.decode(response.body)['data'];
        List<BodQuote> listQuote =
        quote.map((map) => BodQuote.fromJson(map)).toList();
        notifyListeners();
        return listQuote;
      }else if(response.statusCode == 401 || response.statusCode == 403){
        sessionExpired();
      }else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<List<UserLogin>> getUserLogin(String strToken) async {
    try{
      final response = await client.get('$endpoint/User/GetUserProfile',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        Iterable data = json.decode(response.body)['data'];
        List<UserLogin> listData =
        data.map((map) => UserLogin.fromJson(map)).toList();
        notifyListeners();
        return listData;
      }else if(response.statusCode == 401 || response.statusCode == 403){
        sessionExpired();
      }else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<bool> updateProfile(String strFullName, String strEmail, String strPhoneNumber, String strToken) async {
    try{
      final response = await client.post('$endpoint/User/EditProfile',
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $strToken"
          },
          body: json.encode({
            "PhoneNumber": "$strPhoneNumber",
            "Email": "$strEmail",
            "FullName": "$strFullName"
          })
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        if (json.decode(response.body)['isSuccess'] == true) {
          String message = json.decode(response.body)['message'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', message);
          return true;
        } else {
          String message = json.decode(response.body)['message'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', message);
          return false;
        }
      } else {
        String message = "Error occured while Communication with Server with StatusCode "+response.statusCode.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('message', message);
        return false;
      }
    }catch(e){
      String message = "Error : "+e;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('message', message);
      return false;
    }
  }

  Future<bool> changePassword(String strUsername, String strOldPassword, String strNewPassword, String strConfirmPassword, String strToken) async {
    try{
      final response = await client.post('$endpoint/User/ChangePasswordUnAuthorized',
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $strToken"
          },
          body: json.encode({
            "UserName": "$strUsername",
            "Password": "$strOldPassword",
            "NewPassword": "$strNewPassword",
            "ConfirmPassword": "$strConfirmPassword"
          })
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        if (json.decode(response.body)['isSuccess'] == true) {
          String message = json.decode(response.body)['message'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', message);
          return true;
        } else {
          String message = json.decode(response.body)['message'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', message);
          return false;
        }
      } else {
        String message = "Error occured while Communication with Server with StatusCode "+response.statusCode.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('message', message);
        return false;
      }
    }catch(e) {
      String message = "Error : " + e;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('message', message);
      return false;
    }
  }

  Future<List<BankAccount>> getBankAcccount(String strToken) async {
    try{
      final response = await client.get('$endpoint/User/GetBankAccount',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        Iterable data = json.decode(response.body)['data'];
        List<BankAccount> listData =
        data.map((map) => BankAccount.fromJson(map)).toList();
        notifyListeners();
        return listData;
      }else if(response.statusCode == 401 || response.statusCode == 403){
        sessionExpired();
      }else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<List<BankAccount>> getBank(String strToken) async {
    try{
      final response = await client.get('$endpoint/User/GetBankAccount',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        Iterable data = json.decode(response.body)['data'];
        List<BankAccount> listData =
        data.map((map) => BankAccount.fromJson(map)).toList();
        notifyListeners();
        return listData;
      }else if(response.statusCode == 401 || response.statusCode == 403){
        sessionExpired();
      }else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<bool> submitBankAccount(String strAccountName, String strBankId, String strAccountNumber, String strToken) async {
    try{
      final response = await client.post('$endpoint/User/SubmitBankAccount',
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $strToken"
          },
          body: json.encode({
            "AccountNumber": "$strAccountNumber",
            "AccountName": "$strAccountName",
            "BankId": "$strBankId"
          })
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        if (json.decode(response.body)['isSuccess'] == true) {
          String message = json.decode(response.body)['message'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', message);
          return true;
        } else {
          String message = json.decode(response.body)['message'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', message);
          return false;
        }
      } else {
        String message = "Error occured while Communication with Server with StatusCode "+response.statusCode.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('message', message);
        return false;
      }
    }catch(e){
      String message = "Error : "+e;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('message', message);
      return false;
    }
  }

  Future<List<WhatsOn>> getWhatsOn(String strToken) async {
    try{
      final response = await client.get('$endpoint/WhatsOn/GetListWhatsOn',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        Iterable data = json.decode(response.body)['data'];
        List<WhatsOn> listData =
        data.map((map) => WhatsOn.fromJson(map)).toList();
        notifyListeners();
        return listData;
      }else if(response.statusCode == 401 || response.statusCode == 403){
        sessionExpired();
      }else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }


  Future<bool> changeProfilePicture(File file, String strToken) async {
    try{
      String fileName = file.path.split('/').last;

      FormData data = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });

      Response response;
      var headers = {
        "Content-Type": "multipart/form-data",
        "Authorization": "Bearer ${strToken}",
      };

      Dio dio = new Dio();
      response = await dio.post('$endpoint/User/UploadProfile',
          data: data,
          options: Options(
            headers: headers,
          )).timeout(const Duration (seconds:_timeout));

      if(response.statusCode == 200){
        if(response.data['isSuccess'] == true) {
          return true;
        }else {
          String message = json.decode(response.data)['message'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', message);
          return false;
        }
      }else{
        String message = "Error occured while Communication with Server with StatusCode "+response.statusCode.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('message', message);
        return false;
      }
    }catch(e){
      String message = "Error : "+e;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('message', message);
      return false;
    }
  }

  Future<bool> registerAccount(String strFullname, String strUsername, String strEmail, String strPhoneNumber, String strReferalCode, String strPassword, String strToken) async {
    try{
      final response = await client.post('$endpoint/Account/AddRegistrationMember',
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $strToken"
          },
          body: json.encode({
            "UserName": "$strUsername",
            "Password": "$strPassword",
            "PhoneNumber": "$strPhoneNumber",
            "Email": "$strEmail",
            "FullName": "$strFullname",
            "ReferralCode": "$strReferalCode"
          })
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        if (json.decode(response.body)['isSuccess'] == true) {
          String message = json.decode(response.body)['message'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', message);
          return true;
        } else {
          String message = json.decode(response.body)['message'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', message);
          return false;
        }
      } else {
        String message = "Error occured while Communication with Server with StatusCode "+response.statusCode.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('message', message);
        return false;
      }
    }catch(e){
      String message = "Error : "+e;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('message', message);
      return false;
    }
  }

  Future<List<Notifications>> getNotification(String strToken) async {
    try{
      final response = await client.get('$endpoint/Notification/Get',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        Iterable data = json.decode(response.body)['data'];
        List<Notifications> listData =
        data.map((map) => Notifications.fromJson(map)).toList();
        notifyListeners();
        return listData;
      }else if(response.statusCode == 401 || response.statusCode == 403){
        sessionExpired();
      }else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<List<Notifications>> getNotificationUnread(String strToken) async {
    try{
      final response = await client.get('$endpoint/Notification/GetUnreadOnly',

        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        Iterable data = json.decode(response.body)['data'];
        List<Notifications> listData =
        data.map((map) => Notifications.fromJson(map)).toList();
        notifyListeners();
        return listData;
      }else if(response.statusCode == 401 || response.statusCode == 403){
        sessionExpired();
      }else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<bool> getNotificationRead(String strToken) async {
    try{
      final response = await client.post('$endpoint/Notification/Read',
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $strToken"
          }
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        if (json.decode(response.body)['isSuccess'] == true) {
          return true;
        } else {
          String message = json.decode(response.body)['message'].toString();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('message', message);
          return false;
        }
      } else {
        String message = "Error occured while Communication with Server with StatusCode "+response.statusCode.toString();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('message', message);
        return false;
      }
    }catch(e){
      String message = "Error : "+e;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('message', message);
      return false;
    }
  }


  Future<List<InviteFriends>> getInviteFriends(String strToken) async {
    try{
      final response = await client.get('$endpoint/Account/GetInviteFriend',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        Iterable data = json.decode(response.body)['data'];
        List<InviteFriends> listData =
        data.map((map) => InviteFriends.fromJson(map)).toList();
        notifyListeners();
        return listData;
      }else if(response.statusCode == 401 || response.statusCode == 403){
        sessionExpired();
      }else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }

  Future<List<Reward>> getReward(String strToken) async {
    try{
      final response = await client.get('$endpoint/Reward/GetReward',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },
      ).timeout(const Duration (seconds:_timeout));
      if (response.statusCode == 200) {
        Iterable data = json.decode(response.body)['data'];
        List<Reward> listData =
        data.map((map) => Reward.fromJson(map)).toList();
        notifyListeners();
        return listData;
      }else if(response.statusCode == 401 || response.statusCode == 403){
        sessionExpired();
      }else {
        errorRequestWithResponseCode(response.statusCode.toString());
      }
    }catch(e){
      errorCatch(e.toString());
    }
  }
}