import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iglo_world/core/models/whats_on.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/help_view.dart';
import 'package:iglo_world/ui/views/home_view.dart';
import 'package:iglo_world/ui/views/job_position_view.dart';
import 'package:iglo_world/ui/views/login_view.dart';
import 'package:iglo_world/ui/views/profile_view.dart';
import 'package:iglo_world/ui/views/whatson_view.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';


class DrawerWidget extends StatefulWidget {
  final String title;


  DrawerWidget({Key key, this.title}) : super(key: key);

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String spfUserType = "";

  getSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    spfUserType = await prefs.getString('user_type');
  }

  @override
  void initState() {
    getSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userType = "";
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();
    prefs.then((pref){
      userType = pref.getString('user_type');
      print("user type -> "+userType);
    });

    //print("user type dari session -> "+spfUserType);

    bool visibility = false;
    if(userType == "Internal"){
      visibility = true;
    }else{
      visibility = false;
    }

    ScreenUtil.init(context, allowFontScaling: true);
    return Drawer(
      child: Container(
        color: backgroundLightColor,
        child: ListView(
          padding: EdgeInsets.only(top: ScreenUtil().setWidth(200), left: ScreenUtil().setWidth(32), right: ScreenUtil().setWidth(32), bottom: ScreenUtil().setWidth(32)),
          children: [
            ListTile(
              leading: Icon(FontAwesomeIcons.home, color: Colors.white, size: ScreenUtil().setSp(40),),
              title: Text("HOME", style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(32)),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeView(),
                    )
                );
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.suitcase, color: Colors.white, size: ScreenUtil().setSp(40),),
              title: Text("JOB POSITION", style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(32),),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobPositionView(),
                    )
                );
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.calendarAlt, color: Colors.white, size: ScreenUtil().setSp(40),),
              title: Text("WHAT'S ON", style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(32),),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WhatsOnView(),
                    )
                );
              },
            ),
            /*Visibility(
              child: ListTile(
                leading: Icon(FontAwesomeIcons.questionCircle, color: Colors.white, size: ScreenUtil().setSp(40),),
                title: Text("EMPLOYEE SERVICES", style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(32),),),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HelpView(),
                      )
                  );
                },
                enabled: visibility,
              ),
              visible: visibility,
            ),*/
            userType != "Internal" ?
            ListTile(
              leading: Icon(FontAwesomeIcons.questionCircle, color: Colors.white, size: ScreenUtil().setSp(40),),
              title: Text("EMPLOYEE SERVICES", style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(32),),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HelpView(),
                    )
                );
              },
            ) : Container(),
            ListTile(
              leading: Icon(FontAwesomeIcons.star, color: Colors.white, size: ScreenUtil().setSp(40),),
              title: Text("PROFILE", style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(32),),),
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileView(),
                    )
                );
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.shareAlt, color: Colors.white, size: ScreenUtil().setSp(40),),
              title: Text("SHARE THIS APP", style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(32),),),
              onTap: (){
                Share.share('check out my website https://example.com');
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.signOutAlt, color: Colors.white, size: ScreenUtil().setSp(40),),
              title: Text("LOG OUT", style: TextStyle(color: Colors.white, fontSize: ScreenUtil().setSp(32),),),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                SweetAlert.show(context,
                    //title: "Logout",
                    subtitle: "Are you sure logout this program ?",
                    style: SweetAlertStyle.confirm,
                    showCancelButton: true, onPress: (bool isConfirm) {
                      if (isConfirm) {
                        prefs.remove('is_login');
                        prefs.remove('user_id');
                        prefs.remove('role_id');
                        prefs.remove('user_type');
                        prefs.remove('full_name');
                        prefs.remove('position_name');

                        SweetAlert.show(context,subtitle: "Logout...", style: SweetAlertStyle.loading);
                        new Future.delayed(new Duration(seconds: 1),(){
                          SweetAlert.show(context,subtitle: "Success Logout!", style: SweetAlertStyle.success);
                        });
                        // return false to keep dialog
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) => LoginView()),
                                (Route<dynamic> route) => false
                        );
                        return false;
                      }
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
