
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iglo_world/core/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WatsOn2View extends StatefulWidget {
  @override
  _WatsOnViewState createState() => _WatsOnViewState();
}

class _WatsOnViewState extends State<WatsOn2View> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int pageNum = 1;
  bool isPageLoading = false;
  List<Map<String, dynamic>> arrayOfProducts;
  ScrollController controller;
  Future<List<Map<String, dynamic>>> future;
  int totalRecord = 0;

  @override
  void initState() {
    controller = new ScrollController()..addListener(_scrollListener);
    future = _callAPIToGetListOfData();

    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final constListView = ListView.builder(
        itemCount: arrayOfProducts == null ? 0 : arrayOfProducts.length,
        controller: controller,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: <Widget>[
              ListTile(
                title: Text('$index ${arrayOfProducts[index]['title']}'),
                leading: CircleAvatar(backgroundImage: NetworkImage(arrayOfProducts[index]['thumbnail'] ?? "")),
              ),
              Container(
                color: Colors.black12,
                height: (index == arrayOfProducts.length-1 && totalRecord > arrayOfProducts.length) ? 50 : 0,
                width: MediaQuery.of(context).size.width,
                child:Center(
                    child: CircularProgressIndicator()
                ),
              )
            ],
          );
        });
    return Scaffold(
        appBar: AppBar(
          title: Text("Online Products"),
          centerTitle: true,
        ),
        body: Container(
          child: FutureBuilder<List<Map<String, dynamic>>>(
              future: future,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return Center(child: CircularProgressIndicator());
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      Text(
                          'YOu have some error : ${snapshot.hasError.toString()}');
                    } else if (snapshot.data != null) {
                      isPageLoading = false;

                      print(arrayOfProducts);
                      return constListView;
                    }
                }
              }),
        ));
  }

  Future<List<Map<String, dynamic>>> _callAPIToGetListOfData() async {
    isPageLoading = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String strToken = prefs.getString('token');
    final responseDic = await http.post(Api.endpoint+'/JobCategory/GetListCategory',
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer "+strToken
        },);
    Map<String, dynamic> dicOfRes = json.decode(responseDic.body);
    List<Map<String, dynamic>> temArr =
    List<Map<String, dynamic>>.from(dicOfRes["data"]["products"]);
    setState(() {
      if (pageNum == 1) {
        totalRecord = dicOfRes["total_record"];
        print('============>>>>>>> $totalRecord');
        arrayOfProducts = temArr;
      } else {
        arrayOfProducts.addAll(temArr);
      }
      pageNum++;
    });
    return arrayOfProducts;
  }

  _scrollListener() {
    if (totalRecord == arrayOfProducts.length) {
      return;
    }
    print(controller.position.extentAfter);
    if (controller.position.extentAfter <= 0 && isPageLoading == false) {
      _callAPIToGetListOfData();
    }
  }
}