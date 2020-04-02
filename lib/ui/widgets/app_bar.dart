import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/help_view.dart';
import 'package:iglo_world/ui/views/notification_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppBarWidget extends StatefulWidget with PreferredSizeWidget{
  final String title, type;
  final GlobalKey<ScaffoldState> scaffoldKey;

  AppBarWidget({Key key, this.title, this.scaffoldKey, this.type}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {

  String spfUserType = "";
  int spfNotification = 0;

  getSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    spfUserType = prefs.getString('user_type');
    spfNotification = prefs.getInt('total_unread');
  }

  @override
  void initState() {
    getSharedPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      //backgroundColor: Color(0xffa72026),
      flexibleSpace: widget.type == "text" ?
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  Color(0xffE82329),
                  Color(0xffFF4D00),
                ])
        ),
      ) : Container(
        decoration: BoxDecoration(
            color: backgroundLightColor
        ),
      ),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: widget.type == "text" ? Text(widget.title, style: TextStyle(fontSize: 14),) : Image.asset('assets/images/title.png', fit: BoxFit.cover, width: 120),
      leading:widget.type == "text" ?  IconButton(
        icon: new Icon(Icons.arrow_back, size: 14,),
        onPressed: () => Navigator.of(context).pop(),
      ) : null,
      actions: <Widget>[
        spfNotification == 0 || spfNotification == null ?
        IconButton(
          icon: Icon(
            FontAwesomeIcons.bell,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NotificationView()
              ),
            );
          },
        ) :
        IconButton(
          icon: Badge(
            badgeContent: Text(spfNotification.toString(), style: TextStyle( color: Colors.white, fontSize: 10),),
            badgeColor: backgroundDarkColor,
            child: Icon(
              FontAwesomeIcons.bell,
              color: Colors.white,
              size: 20,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NotificationView()
              ),
            );
          },
        ),
        // action button
        Visibility(
          child: IconButton(
            icon: Icon(
              FontAwesomeIcons.questionCircle,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HelpView()
                ),
              );
            },
          ),
          visible: spfUserType == "External" ? false : true,
        ),
        IconButton(
          icon: Icon(
            FontAwesomeIcons.bars,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () {
            widget.scaffoldKey.currentState.openEndDrawer();
          },
        ),
      ],
    );
  }
}
