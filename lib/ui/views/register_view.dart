
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/viewmodels/register_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/login_view.dart';
import 'package:iglo_world/ui/widgets/custom_toast_content_widget.dart';
import 'package:iglo_world/ui/widgets/gradient_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _txtFullName = TextEditingController();
  final TextEditingController _txtUserName = TextEditingController();
  final TextEditingController _txtEmail = TextEditingController();
  final TextEditingController _txtPhoneNumber = TextEditingController();
  final TextEditingController _txtReferalCode = TextEditingController();
  final TextEditingController _txtPassword = TextEditingController();
  final TextEditingController _txtConfirmPassword = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterViewModel>(
      builder: (context, model, child) =>
          Scaffold(
            key: _scaffoldKey,
            backgroundColor: Color.fromRGBO(243, 245, 248, 1),
            appBar: AppBar(
              //backgroundColor: Color(0xffa72026),
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: <Color>[
                          Color(0xffE82329),
                          Color(0xffFF4D00),
                        ])
                ),
              ),
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Text("Register", style: TextStyle(fontSize: 14),),
              leading: IconButton(
                icon: new Icon(Icons.arrow_back, size: 14,),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: ModalProgressHUD(
              inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(15),
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
                                padding: EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
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
                                        controller: _txtFullName,
                                        keyboardType: TextInputType.text,
                                        inputFormatters: [WhitelistingTextInputFormatter(new RegExp('[a-zA-Z ]'))],
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Full Name',
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
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
                                          "Username",
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
                                        controller: _txtUserName,
                                        keyboardType: TextInputType.text,
                                        autofocus: false,
                                        inputFormatters: [WhitelistingTextInputFormatter(new RegExp('[a-zA-Z0-9._]'))],
                                        decoration: InputDecoration(
                                          hintText: 'Enter Username',
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
                                      ),
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
                                    SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "Refferal Code (Optional)",
                                          style: TextStyle(),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 40,
                                      child: TextField(
                                        controller: _txtReferalCode,
                                        keyboardType: TextInputType.text,
                                        inputFormatters: [WhitelistingTextInputFormatter(new RegExp('[a-zA-Z0-9]'))],
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Referal Code (Optional)',
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
                                          "Password",
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
                                        controller: _txtPassword,
                                        obscureText: model.hidePass,
                                        keyboardType: TextInputType.text,
                                        inputFormatters: [WhitelistingTextInputFormatter(new RegExp('[a-zA-Z0-9.]'))],
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Password',
                                          filled: true,
                                          fillColor: Colors.white,
                                          prefixStyle: (
                                              TextStyle(
                                                  backgroundColor: Colors.white,
                                                  fontSize: 12
                                              )
                                          ),
                                          contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: const BorderSide(color: Colors.white, width: 0.0)),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              model.hidePass
                                                  ? FontAwesomeIcons.eyeSlash
                                                  : FontAwesomeIcons.eye,
                                              color: Colors.black,
                                              size: 12,
                                            ),
                                            onPressed: () => model.changeHidePass(),
                                          ),
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
                                          "Confirm Password",
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
                                          controller: _txtConfirmPassword,
                                          obscureText: model.hidePass2,
                                          keyboardType: TextInputType.text,
                                          inputFormatters: [WhitelistingTextInputFormatter(new RegExp('[a-zA-Z0-9.]'))],
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            hintText: 'Enter Confirm Password',
                                            filled: true,
                                            fillColor: Colors.white,
                                            prefixStyle: (
                                              TextStyle(
                                                  backgroundColor: Colors.white,
                                                  fontSize: 12
                                              )
                                            ),
                                            contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: const BorderSide(color: Colors.white, width: 0.0)),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                model.hidePass2
                                                    ? FontAwesomeIcons.eyeSlash
                                                    : FontAwesomeIcons.eye,
                                                color: Colors.black,
                                                size: 12
                                              ),
                                              onPressed: () => model.changeHidePass2(),
                                            ),
                                          ),
                                          style: TextStyle(
                                              backgroundColor: Colors.white,
                                              fontSize: 12
                                          ),
                                        ),
                                    ),
                                    SizedBox(height: 30),
                                    RaisedGradientButton(
                                        child: Text(
                                          'SUBMIT',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[backgroundLightColor, backgroundLightColor2],
                                        ),
                                        onPressed: () async {
                                          var submitSuccess = await model.registerAccount(
                                              _txtFullName.text.trimLeft().trimRight(),
                                              _txtUserName.text.trimLeft().trimRight(),
                                              _txtEmail.text.trimLeft().trimRight(),
                                              _txtPhoneNumber.text.trimLeft().trimRight(),
                                              _txtReferalCode.text.trimLeft().trimRight(),
                                              _txtPassword.text.trimLeft().trimRight(),
                                              _txtConfirmPassword.text.trimLeft().trimRight()
                                          );
                                          if (submitSuccess) {
                                            showToastWidget(IconToastWidget.success(msg: "Successfully Register Account"),
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
                                                  builder: (context) => LoginView(),
                                                )
                                            );
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