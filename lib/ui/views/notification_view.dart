
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/viewmodels/home_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/login_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:iglo_world/ui/widgets/skeleton.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sweetalert/sweetalert.dart';

class NotificationView extends StatefulWidget {
  @override
  _NotificationViewState createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void setShared() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('total_unread', 0);
  }

  @override
  void initState() {
    setShared();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        onModelReady: (model) => model.getNotifications(),
        builder: (context, model, child) => Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBarWidget(title: "Notification", scaffoldKey: _scaffoldKey, type: "text",),
          endDrawer: DrawerWidget(),
          body: model.notifications == null ? Center(child: NotificationSkeleton(),) : ModalProgressHUD(
          inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
            child: SingleChildScrollView(
              child: Container(
                color: Color.fromRGBO(243, 245, 248, 1),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.notifications.length,
                      controller: ScrollController(keepScrollOffset: false),
                      itemBuilder: (BuildContext context, int index) => Container(
                        child: InkWell(
                          onTap: (){
                            SweetAlert.show(context, title: "Under Development");
                          },
                          child: Card(
                            elevation: 0,
                            color: model.notifications[index].isRead == "false" ? Color(0xFFEFEFEF) : Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  //Icon(FontAwesomeIcons.model.notifications[index].notificationIcon, color: Colors.model.notificatio[index].notificationColor, size: 14,),
                                  Expanded(
                                    flex: 1,
                                    child: Icon(
                                        model.notifications[index].categoryId == "1" ? FontAwesomeIcons.questionCircle :
                                        model.notifications[index].categoryId == "2" ? FontAwesomeIcons.suitcase :
                                        model.notifications[index].categoryId == "3" ? FontAwesomeIcons.bullhorn :
                                        model.notifications[index].categoryId == "4" ? FontAwesomeIcons.birthdayCake :
                                        FontAwesomeIcons.bell
                                        , color: model.notifications[index].categoryId == "1" ? Colors.green :
                                    model.notifications[index].categoryId == "2" ? Colors.blue :
                                    model.notifications[index].categoryId == "3" ? Colors.red :
                                    model.notifications[index].categoryId == "4" ? Colors.purple :
                                    Colors.orange
                                        , size: 16),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    flex: 10,
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                              children: <Widget>[
                                                Text(
                                                  model.notifications[index].categoryName,
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                SizedBox(width: 10,),
                                                Visibility(
                                                  child: Badge(
                                                    badgeColor: backgroundLightColor,
                                                    shape: BadgeShape.square,
                                                    borderRadius: 10,
                                                    toAnimate: false,
                                                    badgeContent:
                                                    Text('New', style: TextStyle(color: Colors.white,)),
                                                  ),
                                                  visible: model.notifications[index].isRead == "false" ? true : false,
                                                )
                                              ]
                                          ),
                                          SizedBox(height: 10,),
                                          Row(
                                            children: <Widget>[
                                              Text(
                                                model.notifications[index].title,
                                                style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 10
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                model.notifications[index].notificationDateString,
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontStyle: FontStyle.italic,
                                                  fontSize: 10
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.right,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            )
          ),
        )
    );
  }
}


