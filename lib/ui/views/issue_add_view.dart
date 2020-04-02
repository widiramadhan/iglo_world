
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/services/api.dart';
import 'package:iglo_world/core/utility/app_utility.dart';
import 'package:iglo_world/core/viewmodels/add_ticket_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/help_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/custom_toast_content_widget.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:iglo_world/ui/widgets/gradient_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:sweetalert/sweetalert.dart';
import 'package:toast/toast.dart';

class IssueAddView extends StatefulWidget {
  @override
  _IssueAddViewState createState() => _IssueAddViewState();
}


class _IssueAddViewState extends State<IssueAddView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _txtIssue = TextEditingController();
  final TextEditingController _txtSubject = TextEditingController();
  final TextEditingController _txtDescription = TextEditingController();

  String _valueIssue;
  List listIssue = List();

  Future<String> getListIssue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String spfToken = prefs.getString('token') ?? '';

    var res = await http.get(Uri.encodeFull(Api.endpoint+"/Ticket/GetListIssue"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $spfToken"
        });
    var resBody = json.decode(res.body)['data'];
    setState(() {
      listIssue = resBody;
    });
    return "Sucess";
  }

  DropdownButton _dropdownListIssue() => DropdownButton(
    hint: new Text("Select Issue"),
    items: listIssue.map((item) {
      return new DropdownMenuItem(
        value: item['id'].toString() != null ? item['id'].toString() : "",
        child: new Text(item['name'] != null ? item['name'] : "", maxLines: 1, overflow: TextOverflow.ellipsis),
      );
    }).toList(),
    onChanged: (newVal) {
      setState(() {
        _valueIssue = newVal;
      });
    },
    value: _valueIssue,
  );


  @override
  void initState() {
    super.initState();
    this.getListIssue();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AddTicketViewModel>(
      builder: (context, model, child) =>
          Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomPadding: false,
            backgroundColor: Color.fromRGBO(243, 245, 248, 1),
            appBar: AppBarWidget(title: "Issue",
              scaffoldKey: _scaffoldKey,
              type: "text",),
            endDrawer: DrawerWidget(),
            body: ModalProgressHUD(
              inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
              child: listIssue.isEmpty ? Center( child:CircularProgressIndicator()) : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Let us help you!",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14
                                  ),
                                ),
                                SizedBox(height: 20,),
                                /*Text(
                                  "Issue"
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.only(right: 10, left: 10),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(32),
                                      border: Border.all(color: Colors.grey)
                                  ),
                                  child: DropdownButtonHideUnderline(child: _dropdownListIssue()),
                                ),
                                SizedBox(height: 10),*/
                                Row(
                                  children: <Widget>[
                                    Text(
                                        "Subject",
                                      style: TextStyle(
                                      ),
                                    ),
                                    Text(
                                      " * ",
                                      style: TextStyle(
                                          color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  height: 40,
                                  child: TextField(
                                    controller: _txtSubject,
                                    keyboardType: TextInputType.text,
                                    inputFormatters: [WhitelistingTextInputFormatter(new RegExp('[a-zA-Z ]'))],
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Subject',
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide: const BorderSide(color: Colors.white, width: 0.0)),
                                    ),
                                    style: TextStyle(
                                      backgroundColor: Colors.white,
                                      fontSize: 12
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  children: <Widget>[
                                    Text(
                                        "Description",
                                      style: TextStyle(
                                      ),
                                    ),
                                    Text(
                                        " * ",
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  child: TextField(
                                    controller: _txtDescription,
                                    keyboardType: TextInputType.text,
                                    inputFormatters: [WhitelistingTextInputFormatter(new RegExp('[a-zA-Z ]'))],
                                    autofocus: false,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Description',
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: const BorderSide(color: Colors.white, width: 0.0)),
                                    ),
                                    style: TextStyle(
                                      backgroundColor: Colors.white,
                                      fontSize: 12
                                    ),
                                  ),
                                ),
                                /*SizedBox(height: 20,),
                                RaisedGradientButton(
                                  width: 170,
                                  child: Container(
                                    padding: EdgeInsets.only(top:10, bottom: 10, left: 20, right: 20),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Attachment",
                                          style: TextStyle(color: backgroundLightColor, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width:30),
                                        Icon(
                                          Icons.cloud_upload,
                                          color: backgroundLightColor,
                                        )
                                      ],
                                    ),
                                  ),
                                  gradient: LinearGradient(
                                    colors: <Color>[Colors.red[100], Colors.red[100]],
                                  ),
                                ),*/
                                SizedBox(height: 30),
                                RaisedGradientButton(
                                    child: Text(
                                      'SUBMIT ISSUE',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,  ),
                                    ),
                                    gradient: LinearGradient(
                                      colors: <Color>[backgroundLightColor, backgroundLightColor2],
                                    ),
                                    onPressed: () async {
                                      var submitSuccess = await model.addTicket(
                                          _valueIssue,
                                          _txtSubject.text,
                                          _txtDescription.text);
                                      if (submitSuccess) {
                                        //showToast("Successfully Add Issue");
                                        showToastWidget(IconToastWidget.success(msg: "Successfully add issue"),
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
                                        /*if (Navigator.canPop(context)) {
                                          Navigator.pop(context);
                                        } else {
                                          SystemNavigator.pop();
                                        }*/
                                      }
                                    }
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          )
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          ),
    );
  }
}