import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/viewmodels/home_viewmodel.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:skeleton_text/skeleton_text.dart';

class BODView extends StatefulWidget {
  @override
  _BODViewState createState() => _BODViewState();
}

class _BODViewState extends State<BODView> {

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        onModelReady: (model) => model.getBodQuote(),
        builder: (context, model, child) => Container(
        child: model.state == ViewState.Busy
        ? Center(child: CircularProgressIndicator())
        : model.bod.isEmpty ? Center( child: Container( child: Text("There is no data on this page", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)))) : Container(
            height: model.bod.isEmpty ? 40 : 80,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: model.bod.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) => Container(
                  child: Container(
                    width: 250,
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(60))
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.white,
                                      child: ClipOval(
                                        child: model.bod[index].images == null || model.bod[index].images == "" ? Image.asset("assets/images/default_avatar.jpg", fit: BoxFit.contain,)
                                        : CachedNetworkImage(
                                          imageUrl: model.bod[index].images,
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) => new SkeletonAnimation(
                                              child: Container(
                                                width: 70,
                                                height: 70,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                ),
                                              )
                                            ),
                                          errorWidget: (context, url, error) => new Icon(Icons.error),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: 250,
                                      child: Text(
                                        model.bod[index].author != null ? model.bod[index].author : "",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        model.bod[index].position != null ? model.bod[index].position : "",
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.blue
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Container(
                                      width: 250,
                                      child: Text(
                                        model.bod[index].quote != null ? model.bod[index].quote : "",
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ]
                    ),
                  ),
                )
            )
          )
        )
    );
  }
}
