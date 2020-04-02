
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/utility/app_utility.dart';
import 'package:iglo_world/core/viewmodels/issue_detail_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/help_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/custom_toast_content_widget.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:iglo_world/ui/widgets/gradient_button.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sweetalert/sweetalert.dart';

class IssueDetailView extends StatefulWidget {
  String issueId, issueType;

  IssueDetailView({Key key, this.issueId, this.issueType});

  @override
  _IssueDetailViewState createState() => _IssueDetailViewState();
}

class _IssueDetailViewState extends State<IssueDetailView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _txtValue = TextEditingController();

  String spfRoleId = "";
  String spfUsername = "";
  bool keyboardVisual = false;

  getSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    spfRoleId = await prefs.getString('role_id');
    spfUsername = await prefs.getString('username');
    print("username -> "+spfUsername);
  }

  @override
  void initState() {
    getSharedPreferences();
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        this.setState(() {
          keyboardVisual = visible;
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<IssueDetailViewModel>(
      onModelReady: (model) => model.getAllData(widget.issueId),
      builder: (context, model, child) =>
      model.issueComment == null || model.issueDetail == null ? Container(color: Colors.white, child: Center( child: CircularProgressIndicator()),) : Scaffold(
            key: _scaffoldKey,
            //resizeToAvoidBottomPadding: false,
            backgroundColor: Color.fromRGBO(243, 245, 248, 1),
            appBar: AppBarWidget(title: "Detail Tickets",
              scaffoldKey: _scaffoldKey,
              type: "text",),
            endDrawer: DrawerWidget(),
            body: ModalProgressHUD(
              inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
              child: SingleChildScrollView(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: <Widget>[
                                  /*Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Text(
                                            "Issue",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Text(
                                            model.issueDetail[0].issue != null ? model.issueDetail[0].issue : "",
                                            maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),*/
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Text(
                                            "Subject",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Text(
                                            model.issueDetail[0].subject != null ? model.issueDetail[0].subject : "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                             ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height:10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Text(
                                            "Open Ticket Date",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                             ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Text(
                                            model.issueDetail[0].openTicketDate != null ? model.issueDetail[0].openTicketDate : "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                             ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Text(
                                            "Description",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Text(
                                            model.issueDetail[0].description != null ? model.issueDetail[0].description : "",
                                            //textAlign: TextAlign.justify,
                                            maxLines: null,
                                            style: TextStyle(
                                             ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  widget.issueType == "open" ? Container() : Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Text(
                                            "Ticket Expired",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Text(
                                            model.issueDetail[0].ticketExpireDate != null ? model.issueDetail[0].ticketExpireDate : "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: backgroundLightColor,
                                             ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(height: 30,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            RaisedGradientButton(
                                                width: 150,
                                                child: Container(
                                                    padding: EdgeInsets.only(top:0, bottom: 0, left: 20, right: 20),
                                                    child: Text(
                                                      "Need More Time",
                                                      style: TextStyle(color: backgroundLightColor, fontWeight: FontWeight.bold,),
                                                    )
                                                ),
                                                gradient: LinearGradient(
                                                  colors: <Color>[backgroundPinkColor, backgroundPinkColor],
                                                ),
                                                onPressed: () async {
                                                  var needMoreTime = await model.actionNeedMoreTime(widget.issueId);
                                                  if (needMoreTime) {
                                                    /*SweetAlert.show(context, title: "Success", subtitle: "Successfully Request Need More Time for Issue", style: SweetAlertStyle.success);
                                                    model.getAllData(widget.issueId);*/
                                                    showToastWidget(IconToastWidget.success(msg: "Successfully request need more time for issue"),
                                                        context: context,
                                                        animation: StyledToastAnimation.slideFromBottom,
                                                        reverseAnimation: StyledToastAnimation.slideToBottom,
                                                        position: StyledToastPosition.center,
                                                        animDuration: Duration(seconds: 1),
                                                        duration: Duration(seconds: 4),
                                                        curve: Curves.elasticOut,
                                                        reverseCurve: Curves.fastOutSlowIn);
                                                    model.getAllData(widget.issueId);
                                                  }
                                                }
                                            ),
                                            SizedBox(width: 10),
                                            RaisedGradientButton(
                                                width: 150,
                                                child: Container(
                                                    padding: EdgeInsets.only(top:0, bottom: 0, left: 20, right: 20),
                                                    child: Text(
                                                      "Solved",
                                                      style: TextStyle(color: backgroundLightColor, fontWeight: FontWeight.bold,),
                                                    )
                                                ),
                                                gradient: LinearGradient(
                                                  colors: <Color>[backgroundPinkColor, backgroundPinkColor],
                                                ),
                                                onPressed: () async {
                                                  var solved = await model.actionSolved(widget.issueId);
                                                  if (solved) {
                                                    //SweetAlert.show(context, title: "Success", subtitle: "Successfully Solved for Issue", style: SweetAlertStyle.success);
                                                    showToastWidget(IconToastWidget.success(msg: "Successfully Solved for Issue"),
                                                        context: context,
                                                        animation: StyledToastAnimation.slideFromBottom,
                                                        reverseAnimation: StyledToastAnimation.slideToBottom,
                                                        position: StyledToastPosition.center,
                                                        animDuration: Duration(seconds: 1),
                                                        duration: Duration(seconds: 4),
                                                        curve: Curves.elasticOut,
                                                        reverseCurve: Curves.fastOutSlowIn);
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => HelpView(),
                                                        )
                                                    );
                                                  }
                                                }
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                      ],
                                    ),
                                    visible: widget.issueType == "progress" && spfRoleId == "4" ? true : false,
                                  ),
                                  Visibility(
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(height: 20,),
                                        Text("This issue wants to be closed, are you sure it's been resolved?", style: TextStyle(color: Colors.blue,), textAlign: TextAlign.center,),
                                        SizedBox(height:20,),
                                        Container(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                RaisedGradientButton(
                                                    width: 70,
                                                    child: Container(
                                                        padding: EdgeInsets.only(top:0, bottom: 0, left: 20, right: 20),
                                                        child: Text(
                                                          "Yes",
                                                          style: TextStyle(color: backgroundLightColor, fontWeight: FontWeight.bold,),
                                                        )
                                                    ),
                                                    gradient: LinearGradient(
                                                      colors: <Color>[backgroundPinkColor, backgroundPinkColor],
                                                    ),
                                                    onPressed: () async {
                                                      var closed = await model.actionClose(widget.issueId, "true");
                                                      if (closed) {
                                                        //SweetAlert.show(context, title: "Success", subtitle: "Successfully Closed for Issue", style: SweetAlertStyle.success);
                                                        showToastWidget(IconToastWidget.success(msg: "Successfully Closed for Issue"),
                                                            context: context,
                                                            animation: StyledToastAnimation.slideFromBottom,
                                                            reverseAnimation: StyledToastAnimation.slideToBottom,
                                                            position: StyledToastPosition.center,
                                                            animDuration: Duration(seconds: 1),
                                                            duration: Duration(seconds: 4),
                                                            curve: Curves.elasticOut,
                                                            reverseCurve: Curves.fastOutSlowIn);
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => HelpView(),
                                                            )
                                                        );
                                                      }
                                                    }
                                                ),
                                                SizedBox(width: 10),
                                                RaisedGradientButton(
                                                    width: 70,
                                                    child: Container(
                                                        padding: EdgeInsets.only(top:0, bottom: 0, left: 20, right: 20),
                                                        child: Text(
                                                          "No",
                                                          style: TextStyle(color: backgroundLightColor, fontWeight: FontWeight.bold, ),
                                                        )
                                                    ),
                                                    gradient: LinearGradient(
                                                      colors: <Color>[backgroundPinkColor, backgroundPinkColor],
                                                    ),
                                                    onPressed: () async {
                                                      var closed = await model.actionClose(widget.issueId, "false");
                                                      if (closed) {
                                                        //SweetAlert.show(context, title: "Success", subtitle: "Successfully Re-Opened for Issue", style: SweetAlertStyle.success);
                                                        showToastWidget(IconToastWidget.success(msg: "Successfully Re-Opened for Issue"),
                                                            context: context,
                                                            animation: StyledToastAnimation.slideFromBottom,
                                                            reverseAnimation: StyledToastAnimation.slideToBottom,
                                                            position: StyledToastPosition.center,
                                                            animDuration: Duration(seconds: 1),
                                                            duration: Duration(seconds: 4),
                                                            curve: Curves.elasticOut,
                                                            reverseCurve: Curves.fastOutSlowIn);
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => HelpView(),
                                                            )
                                                        );
                                                      }
                                                    }
                                                ),
                                              ],
                                            )
                                        )
                                      ],
                                    ),
                                    visible: widget.issueType == "progress" && model.issueDetail[0].transactionStatus == "7" || model.issueDetail[0].transactionStatus == "11"  ? true : false,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                              child: Text(
                                "Replies",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            widget.issueType == "open" || model.issueComment.isEmpty ? Container(
                              margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                "Waiting for Replies",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ) : Container(
                              margin: EdgeInsets.all(10),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: model.issueComment.length,
                                controller: ScrollController(keepScrollOffset: false),
                                itemBuilder: (BuildContext context, int index) =>
                                  model.issueComment[index].username == spfUsername ?
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            flex:6,
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    model.issueComment[index].fullName != null ? model.issueComment[index].fullName : "",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Container(
                                                      constraints: BoxConstraints(
                                                          maxWidth: MediaQuery.of(context).size.width),
                                                      padding: EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                        color: Color(0xFFFFEAEA),
                                                        borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(10),
                                                          bottomLeft: Radius.circular(10),
                                                          bottomRight: Radius.circular(10),
                                                        ),
                                                      ),
                                                      child: Container(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Text(
                                                              model.issueComment[index].comment != null ? model.issueComment[index].comment : "",
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                              ),
                                                            ),
                                                            SizedBox(height: 10,),
                                                            Container(
                                                                child: Column(
                                                                  children: <Widget>[
                                                                    Text(
                                                                      model.issueComment[index].createDate != null ? model.issueComment[index].createDate : "",
                                                                      style: TextStyle(
                                                                          color: Colors.blue,
                                                                          fontSize: 10,
                                                                          fontStyle: FontStyle.italic
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                  ),
                                                ],
                                              ),
                                            )
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          flex:1,
                                          child: Container(
                                            margin: EdgeInsets.only(top:10),
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.white,
                                              child: ClipOval(
                                                child: model.issueComment[index].filePath == null || model.issueComment[index].filePath == "" ? Image.asset("assets/images/default_avatar.jpg", fit: BoxFit.contain,)
                                                    : CachedNetworkImage(
                                                  imageUrl: model.issueComment[index].filePath,
                                                  fit: BoxFit.fill,
                                                  placeholder: (context, url) => new SkeletonAnimation(
                                                      child: Container(
                                                        width: 70,
                                                        height: 70,
                                                        decoration: BoxDecoration(
                                                          color: Colors.grey[300],
                                                        ),
                                                      )
                                                  ),
                                                  errorWidget: (context, url, error) => new Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          )
                                        ),
                                      ],
                                    ),
                                  ) :
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex:1,
                                          child: Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundColor: Colors.white,
                                              child: ClipOval(
                                                child: model.issueComment[index].filePath == null || model.issueComment[index].filePath == "" ? Image.asset("assets/images/default_avatar.jpg", fit: BoxFit.contain,)
                                                    : CachedNetworkImage(
                                                  imageUrl: model.issueComment[index].filePath,
                                                  fit: BoxFit.fill,
                                                  placeholder: (context, url) => new SkeletonAnimation(
                                                      child: Container(
                                                        width: 70,
                                                        height: 70,
                                                        decoration: BoxDecoration(
                                                          color: Colors.grey[300],
                                                        ),
                                                      )
                                                  ),
                                                  errorWidget: (context, url, error) => new Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          )
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                            flex:6,
                                            child: Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    model.issueComment[index].fullName != null ? model.issueComment[index].fullName : "",
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Container(
                                                      constraints: BoxConstraints(
                                                          maxWidth: MediaQuery.of(context).size.width),
                                                      padding: EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(10),
                                                          bottomLeft: Radius.circular(10),
                                                          bottomRight: Radius.circular(10),
                                                        ),
                                                      ),
                                                      child: Container(
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Text(
                                                              model.issueComment[index].comment != null ? model.issueComment[index].comment : "",
                                                              style: TextStyle(
                                                                  color: Colors.grey,
                                                              ),
                                                            ),
                                                            SizedBox(height: 10,),
                                                            Container(
                                                                child: Column(
                                                                  children: <Widget>[
                                                                    Text(
                                                                      model.issueComment[index].createDate != null ? model.issueComment[index].createDate : "",
                                                                      style: TextStyle(
                                                                          color: Colors.blue,
                                                                          fontSize: 10,
                                                                          fontStyle: FontStyle.italic
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                  ),
                                                ],
                                              ),
                                            )
                                        ),
                                      ],
                                    ),
                                  )
                              ),
                            ),
                          ],
                        ),
                  ),
              )
            ),
            bottomNavigationBar: widget.issueType == "closed" || widget.issueType == "open" && spfRoleId != "4" || model.issueDetail[0].transactionStatus == "11" ? Container(height: 0,) : Container(
              color: Colors.white,
              height: keyboardVisual == true ? MediaQuery.of(context).viewInsets.bottom + 70 : 70,//keyboardHeight,
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _txtValue,
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: InputDecoration(
                  hintText: 'Reply',
                  filled: true,
                  fillColor: Colors.white,
                  prefixStyle: (
                      TextStyle(
                          backgroundColor: Colors.white
                      )
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: const BorderSide(color: Colors.white, width: 0.0)),
                  suffixIcon: InkWell(
                    onTap: () async {
                      var submitSuccess = await model.addComment(
                        widget.issueId,
                        _txtValue.text);
                      if (submitSuccess) {
                        /*SweetAlert.show(context,
                            title: "Success",
                            subtitle: "Successfully Add Comment",
                            style: SweetAlertStyle.success);*/
                        showToastWidget(IconToastWidget.success(msg: "Successfully Add Comment"),
                            context: context,
                            animation: StyledToastAnimation.slideFromBottom,
                            reverseAnimation: StyledToastAnimation.slideToBottom,
                            position: StyledToastPosition.center,
                            animDuration: Duration(seconds: 1),
                            duration: Duration(seconds: 4),
                            curve: Curves.elasticOut,
                            reverseCurve: Curves.fastOutSlowIn);
                        model.getAllData(widget.issueId);
                        _txtValue.text = '';
                      }
                    },
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.paperPlane,
                        color: backgroundLightColor,
                        size: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            resizeToAvoidBottomInset: false,
          ),
    );
  }
}