
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/utility/app_utility.dart';
import 'package:iglo_world/core/viewmodels/whatson_viewmodel.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/photo_viewer_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:skeleton_text/skeleton_text.dart';

class WhatsOnDetailView extends StatefulWidget {
  String title, createDate, value, images;

  WhatsOnDetailView({Key key, this.title, this.createDate, this.value, this.images});

  @override
  _WhatsOnDetailViewState createState() => _WhatsOnDetailViewState();
}

class _WhatsOnDetailViewState extends State<WhatsOnDetailView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<WhatsOnViewModel>(
        builder: (context, model, child) => Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBarWidget(title: "What's On", scaffoldKey: _scaffoldKey, type: "text",),
          endDrawer: DrawerWidget(),
          body: ModalProgressHUD(
          inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PhotoViewerView(path: widget.images),
                            )
                        );
                      },
                      child: CachedNetworkImage(
                        imageUrl: widget.images,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                        placeholder: (context, url) => new SkeletonAnimation(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                              ),
                            )
                        ),
                        errorWidget: (context, url, error) => new Icon(Icons.error),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            "Published on "+widget.createDate,
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Text(
                            widget.value,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ),
        )
    );
  }
}