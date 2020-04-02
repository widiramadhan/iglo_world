
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/utility/app_utility.dart';
import 'package:iglo_world/core/viewmodels/home_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/login_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/issue_closed_view.dart';
import 'package:iglo_world/ui/views/issue_open_view.dart';
import 'package:iglo_world/ui/views/issue_waiting_view.dart';
import 'package:iglo_world/ui/views/profile_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/custom_toast_content_widget.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:iglo_world/ui/widgets/gradient_button.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class ProfileEditView extends StatefulWidget {
  final String fullname, email, phone, address, company;

  ProfileEditView({Key key, this.fullname, this.email, this.phone, this.address, this.company});

  @override
  _ProfileEditViewState createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _txtFullName = TextEditingController();
  final TextEditingController _txtEmail = TextEditingController();
  final TextEditingController _txtPhoneNumber = TextEditingController();
  /*final TextEditingController _txtAddress = TextEditingController();
  final TextEditingController _txtCompany = TextEditingController();*/

  @override
  Widget build(BuildContext context) {
    _txtFullName.text = widget.fullname;
    _txtEmail.text = widget.email;
    _txtPhoneNumber.text = widget.phone;
    /*_txtAddress.text = "";//widget.address;
    _txtCompany.text = "";//widget.company;*/

    return BaseView<HomeViewModel>(
      onModelReady: (model) => model.getUserLogin(),
      builder: (context, model, child) =>
          Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomPadding: false,
            backgroundColor: Color.fromRGBO(243, 245, 248, 1),
            appBar: AppBarWidget(title: "Edit Profile",
              scaffoldKey: _scaffoldKey,
              type: "text",),
            endDrawer: DrawerWidget(),
            body: model.user == null ? Center( child: CircularProgressIndicator()) : ModalProgressHUD(
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
                                      contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),//EdgeInsets.fromLTRB(ScreenUtil().setWidth(20.0), ScreenUtil().setWidth(15.0), ScreenUtil().setWidth(20.0), ScreenUtil().setWidth(15.0)),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide: const BorderSide(color: Colors.white, width: 0.0)),
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
                                      "Email",
                                      style: TextStyle(),
                                    ),
                                    Text(
                                      " * ",
                                      style: TextStyle(
                                        color: Colors.red, ),
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
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide: const BorderSide(color: Colors.white, width: 0.0)),
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
                                      "Phone",
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
                                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide: const BorderSide(color: Colors.white, width: 0.0)),
                                    ),
                                    style: TextStyle(
                                      backgroundColor: Colors.white,
                                      fontSize:12,
                                    ),
                                  ),
                                ),
                                /*SizedBox(height: 10),
                                Row(
                                  children: <Widget>[
                                    Text(
                                        "Address"
                                    ),
                                    Text(
                                        " * ",
                                      style: TextStyle(
                                        color: Colors.red
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  controller: _txtAddress,
                                  keyboardType: TextInputType.text,
                                  autofocus: false,
                                  maxLines: 5,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Address',
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),borderSide: const BorderSide(color: Colors.white, width: 0.0)),
                                  ),
                                  style: TextStyle(
                                    backgroundColor: Colors.white,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: <Widget>[
                                    Text(
                                        "Company"
                                    ),
                                    Text(
                                      " * ",
                                      style: TextStyle(
                                          color: Colors.red
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                TextField(
                                  controller: _txtCompany,
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    hintText: 'Enter Company',
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide: const BorderSide(color: Colors.white, width: 0.0)),
                                  ),
                                  style: TextStyle(
                                    backgroundColor: Colors.white,
                                  ),
                                ),*/
                                SizedBox(height: 30),
                                RaisedGradientButton(
                                    child: Text(
                                      'SUBMIT',
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,)),
                                      gradient: LinearGradient(
                                      //colors: <Color>[Color(0xffe82228), Color(0xfff45b27)],
                                      colors: <Color>[backgroundLightColor, backgroundLightColor2],
                                    ),
                                    onPressed: () async {
                                      var submitSuccess = await model.updateProfile(
                                          _txtFullName.text,
                                          _txtEmail.text,
                                          _txtPhoneNumber.text);
                                      if (submitSuccess) {
                                        showToastWidget(IconToastWidget.success(msg: "Successfully Update Profile"),
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
                                              builder: (context) => ProfileView(),
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