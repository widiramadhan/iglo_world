
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/viewmodels/login_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/whatson_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/empty_view.dart';
import 'package:iglo_world/ui/views/whatson_detail_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:skeleton_text/skeleton_text.dart';

class WhatsOnView extends StatefulWidget {
  @override
  _WhatsOnViewState createState() => _WhatsOnViewState();
}

class _WhatsOnViewState extends State<WhatsOnView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return BaseView<WhatsOnViewModel>(
        onModelReady: (model) => model.getWhatsOn(),
        builder: (context, model, child) => Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBarWidget(title: "What's On", scaffoldKey: _scaffoldKey, type: "text",),
          endDrawer: DrawerWidget(),
          body:  model.whatson == null ? Center( child: WhatsOnSkeleton()) : ModalProgressHUD(
          inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
            child: model.whatson.isEmpty ? EmptyDataView() : SingleChildScrollView(
              child: Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.whatson.length,
                  controller: ScrollController(keepScrollOffset: false),
                  itemBuilder: (BuildContext context, int index) =>
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WhatsOnDetailView(title:  model.whatson[index].title != null ? model.whatson[index].title : "", createDate:  model.whatson[index].createdDatetimeString != null ? model.whatson[index].createdDatetimeString : "", value:  model.whatson[index].story != null ? model.whatson[index].story : "", images:  model.whatson[index].imageSource != null ? model.whatson[index].imageSource : "",),
                          )
                      );
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: ScreenUtil().setHeight(400),
                        margin: EdgeInsets.only(right: 20, top:7, bottom:7, left:20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(50))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Stack(
                                alignment: Alignment.bottomLeft,
                                children:  <Widget>[
                                  model.whatson[index].imageSource != null || model.whatson[index].imageSource != "" ?
                                  CachedNetworkImage(
                                      imageUrl: model.whatson[index].imageSource,
                                      fit: BoxFit.fill,
                                      width: MediaQuery.of(context).size.width,
                                      height: ScreenUtil().setHeight(400),
                                      placeholder: (context, url) => new SkeletonAnimation(
                                          child: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: ScreenUtil().setHeight(400),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                            ),
                                          )
                                      ),
                                      errorWidget: (context, url, error) => new Icon(Icons.error),
                                  ) : Container(
                                    height: ScreenUtil().setHeight(400),
                                    color: Colors.grey[300],
                                  ),
                                  Container(
                                    color: backgroundLightColor.withOpacity(0.8),
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Text(model.whatson[index].title != null ? model.whatson[index].title : "", style: TextStyle(fontSize: ScreenUtil().setSp(32), color: Colors.white, fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  )
                                ]
                            ),
                          ],
                        )
                    ),
                  ),
                ),
              ),
            )
          ),
        )
    );
  }
}


class WhatsOnSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return SkeletonAnimation(
          child: Container(
            height: 200,
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[300]
            ),
          ),
        );
      }
    );
  }
}