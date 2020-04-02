
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/utility/app_utility.dart';
import 'package:iglo_world/core/viewmodels/apply_job_position_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/job_position_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/custom_toast_content_widget.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:iglo_world/ui/widgets/gradient_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';
import 'package:toast/toast.dart';

class JobApplyView extends StatefulWidget {
  String job_id;

  JobApplyView({Key key, this.job_id});

  @override
  _JobApplyViewState createState() => _JobApplyViewState();
}

class _JobApplyViewState extends State<JobApplyView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _txtFullname = TextEditingController();
  final TextEditingController _txtEmail = TextEditingController();
  final TextEditingController _txtPhoneNumber = TextEditingController();

  String formattedDate = DateFormat('yyyy-MM-d kk:mm:ss').format(DateTime.now());
  File _berkas;

  Future getCV() async {
    var _file = await FilePicker.getFile(type: FileType.custom, fileExtension: "pdf");
    if(_file != null){
      setState(() {
        _berkas = _file;
        print(_berkas);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ApplyJobPositionViewModel>(
      builder: (context, model, child) =>
          Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomPadding: false,
            backgroundColor: Color.fromRGBO(243, 245, 248, 1),
            appBar: AppBarWidget(title: "Apply",
              scaffoldKey: _scaffoldKey,
              type: "text",),
            endDrawer: DrawerWidget(),
            body: ModalProgressHUD(
              inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Card(
                              color: Colors.white,
                              elevation: 2,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    /*Row(
                                      children: <Widget>[
                                        Text(
                                          "Position : ",
                                          style: TextStyle(
                                              fontSize: 20,
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          "Java Developer",
                                          style: TextStyle(
                                              color: backgroundLightColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),*/
                                    Text(
                                      "Please fill In your reference's data & CV",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 14
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "Full Name",
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          " * ",
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 40,
                                      child: TextField(
                                        controller: _txtFullname,
                                        keyboardType: TextInputType.text,
                                        inputFormatters: [WhitelistingTextInputFormatter(new RegExp('[a-zA-Z ]'))],
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Full Name',
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
                                    SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "Email",
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          " * ",
                                          style: TextStyle(
                                              color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 40,
                                      child: TextField(
                                        controller: _txtEmail,
                                        keyboardType: TextInputType.emailAddress,
                                        inputFormatters: [WhitelistingTextInputFormatter(new RegExp('[a-zA-Z0-9_.@]'))],
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Email',
                                          filled: true,
                                          fillColor: Colors.white,
                                         contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide: const BorderSide(color: Colors.white, width: 0.0)),
                                        ),
                                        style: TextStyle(
                                          backgroundColor: Colors.white,
                                          fontSize: 12
                                        ),
                                      )
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "Phone Number",
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          " * ",
                                          style: TextStyle(
                                              color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 40,
                                      child: TextField(
                                        controller: _txtPhoneNumber,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [WhitelistingTextInputFormatter(new RegExp('[0-9+]'))],
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Phone Number',
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
                                    SizedBox(height: 30),
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: RaisedGradientButton(
                                              width: 400,
                                              child: Container(
                                                padding: EdgeInsets.only(top:10, bottom: 10, left: 20, right: 20),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text("Upload CV", style: TextStyle(color: backgroundLightColor, fontWeight: FontWeight.bold,),),
                                                    ),
                                                    Expanded(
                                                      flex: 1,
                                                      child: Icon(Icons.cloud_upload, color: backgroundLightColor, size:16),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              gradient: LinearGradient(
                                                colors: <Color>[backgroundPinkColor, backgroundPinkColor],
                                              ),
                                              onPressed: () async {
                                                getCV();
                                                FocusScope.of(context).unfocus();
                                              }
                                          ),
                                        ),
                                        SizedBox(width: 10,),
                                        Expanded(
                                          flex: 1,
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: _berkas != null ? Icon(FontAwesomeIcons.checkCircle, color: Colors.green, size: 16,) : Icon(FontAwesomeIcons.checkCircle, color: Colors.grey, size: 16,),
                                              ),
                                              //SizedBox(width: 5,),
                                              Expanded(
                                                flex: 3,
                                                child: _berkas != null ? Text("File selected!", maxLines: null, style: TextStyle()) : Text("Please Select File",  maxLines: null,  style: TextStyle())
                                              )
                                            ],
                                          )
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      "* File formats that can be uploaded are pdf, docx, and doc with size min 2MB",
                                      style: TextStyle(
                                          color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(height: 30,),
                                    RaisedGradientButton(
                                        child: Text(
                                          'SUBMIT',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                        ),
                                        gradient: LinearGradient(
                                          //colors: <Color>[Color(0xffe82228), Color(0xfff45b27)],
                                          colors: <Color>[backgroundLightColor, backgroundLightColor2],
                                        ),
                                        onPressed: () async {
                                          var submitCV = await model.uploadAttachment2(_txtFullname.text, _txtPhoneNumber.text,  _txtEmail.text, _berkas);
                                          if(submitCV){
                                            final SharedPreferences prefs = await SharedPreferences.getInstance();
                                            String attachmentId = prefs.getString('attachment_id');
                                            var submitSuccess = await model.applyJobPosition(
                                                _txtFullname.text,
                                                _txtPhoneNumber.text,
                                                _txtEmail.text,
                                                attachmentId,
                                                widget.job_id.toString());
                                            if (submitSuccess) {
                                              //showToast("Successfully Apply this job");
                                              showToastWidget(IconToastWidget.success(msg: "Successfully applied this job"),
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
                                                    builder: (context) => JobPositionView(),
                                                  )
                                              );
                                            }
                                          }
                                        }
                                    ),
                                    SizedBox(height: 20,),
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