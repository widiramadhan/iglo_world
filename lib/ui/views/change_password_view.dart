
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/utility/app_utility.dart';
import 'package:iglo_world/core/viewmodels/home_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:iglo_world/ui/widgets/gradient_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sweetalert/sweetalert.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (context, model, child) =>
          Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomPadding: false,
            backgroundColor: Color.fromRGBO(243, 245, 248, 1),
            appBar: AppBarWidget(title: "Change Password",
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
                          elevation: 5,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                        "Old Password",
                                      style: TextStyle(),
                                    ),
                                    Text(
                                      " * ",
                                      style: TextStyle(
                                        color: Colors.red,),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 40,
                                  child: TextField(
                                    controller: _oldPassword,
                                    obscureText: model.hidePass,
                                    keyboardType: TextInputType.text,
                                    inputFormatters: [WhitelistingTextInputFormatter(new RegExp('[a-zA-Z0-9.]'))],
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Old Password',
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixStyle: (
                                          TextStyle(
                                            backgroundColor: Colors.white,
                                            fontSize: 12,
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
                                          size: 16,
                                        ),
                                        onPressed: () => model.changeHidePass(),
                                      ),
                                    ),
                                    style: TextStyle(
                                      backgroundColor: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "New Password",
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
                                    controller: _newPassword,
                                    obscureText: model.hidePass2,
                                    keyboardType: TextInputType.text,
                                    inputFormatters: [WhitelistingTextInputFormatter(new RegExp('[a-zA-Z0-9.]'))],
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      hintText: 'Enter New Password',
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixStyle: (
                                          TextStyle(
                                            backgroundColor: Colors.white,
                                            fontSize: 12,
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
                                          size: 16,
                                        ),
                                        onPressed: () => model.changeHidePass2(),
                                      ),
                                    ),
                                    style: TextStyle(
                                      backgroundColor: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Confirm New Password",
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
                                    controller: _confirmPassword,
                                    obscureText: model.hidePass3,
                                    keyboardType: TextInputType.text,
                                    inputFormatters: [WhitelistingTextInputFormatter(new RegExp('[a-zA-Z0-9.]'))],
                                    autofocus: false,
                                    decoration: InputDecoration(
                                      hintText: 'Enter Confirm New Password',
                                      filled: true,
                                      fillColor: Colors.white,
                                      prefixStyle: (
                                          TextStyle(
                                            backgroundColor: Colors.white,
                                            fontSize: 12,
                                          )
                                      ),
                                      contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: const BorderSide(color: Colors.white, width: 0.0)),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          model.hidePass3
                                              ? FontAwesomeIcons.eyeSlash
                                              : FontAwesomeIcons.eye,
                                          color: Colors.black,
                                          size: 16,
                                        ),
                                        onPressed: () => model.changeHidePass3(),
                                      ),
                                    ),
                                    style: TextStyle(
                                      backgroundColor: Colors.white,
                                      fontSize: 12,
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
                                      //colors: <Color>[Color(0xffe82228), Color(0xfff45b27)],
                                      colors: <Color>[backgroundLightColor, backgroundLightColor],
                                    ),
                                    onPressed: () async {
                                      var submitSuccess = await model.changePassword(
                                          _oldPassword.text,
                                          _newPassword.text,
                                          _confirmPassword.text);
                                      if (submitSuccess) {
                                        SweetAlert.show(context,
                                            title: "Success",
                                            subtitle: "Success! Password has been Changed",
                                            style: SweetAlertStyle.success,
                                            onPress: (bool isOk){
                                              if(isOk){
                                                _oldPassword.text = "";
                                                _newPassword.text = "";
                                                _confirmPassword.text = "";
                                              }
                                            }
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