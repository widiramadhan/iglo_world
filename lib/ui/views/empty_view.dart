
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iglo_world/core/utility/app_utility.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';

class EmptyDataView extends StatefulWidget {
  @override
  _EmptyDataViewState createState() => _EmptyDataViewState();
}

class _EmptyDataViewState extends State<EmptyDataView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50, bottom: 50),
      child: Center(
        child: Column(
          children: <Widget>[
            Text("There is no data on this page", style: TextStyle(color: backgroundLightColor, fontWeight: FontWeight.bold, fontSize: 14),)
          ],
        )
      ),
    );
  }
}