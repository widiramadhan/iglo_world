import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/viewmodels/home_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/whatson_detail_view.dart';
import 'package:skeleton_text/skeleton_text.dart';

class WhatsOnSlider extends StatefulWidget {
  @override
  _WhatsOnSliderState createState() => _WhatsOnSliderState();
}

class _WhatsOnSliderState extends State<WhatsOnSlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return  BaseView<HomeViewModel>(
        onModelReady: (model) => model.getWhatsOn(),
        builder: (context, model, child) => Container(
            child: model.state == ViewState.Busy
                ? Center(child: CircularProgressIndicator())
                : model.whatson.isEmpty ? Center( child: Container( child: Text("There is no data on this page", style: TextStyle(color: backgroundLightColor, fontWeight: FontWeight.bold, fontSize: 14)))) : Container(
                  width: MediaQuery.of(context).size.width,
                  height: model.whatson.isEmpty ? 40 : 180,
                          /*child: CarouselSlider(
                            autoPlay: true,
                            pauseAutoPlayOnTouch: Duration(seconds: 5),
                            aspectRatio: 2.0,
                            onPageChanged: (index) {
                              setState(() {
                                _current = index;
                              });
                            },
                            items: <Widget>[
                              for (var i = 0; i < model.whatson.length; i++)
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(right: 5, left: 5),
                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children:  <Widget>[
                                      model.whatson[i].imageSource != null || model.whatson[i].imageSource != "" ?
                                      CachedNetworkImage(
                                        imageUrl: model.whatson[i].imageSource,
                                        fit: BoxFit.fill,
                                        width: MediaQuery.of(context).size.width,
                                        height: 150,
                                        placeholder: (context, url) => new SkeletonAnimation(
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                              ),
                                            )
                                        ),
                                        errorWidget: (context, url, error) => new Icon(Icons.error),
                                      ) :
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 150,
                                        color: Colors.grey[300],
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: backgroundLightColor.withOpacity(0.8),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Text(model.whatson[i].title != null ? model.whatson[i].title : "", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),*/
                          /*child: SizedBox(
                              height: 200.0,
                              width: 350.0,
                              child: Carousel(
                                images: [//model.jobPosition.length <= 5 ? model.jobPosition.length : 5,
                                  for (var i = 0; i < (model.whatson.length <= 3 ? model.whatson.length : 3); i++)
                                    GestureDetector( child: Image.network(model.whatson[i].imageSource)),
                                ],
                                dotSize: 5.0,
                                dotSpacing: 15.0,
                                dotColor: Colors.white,
                                indicatorBgPadding: 5.0,
                                dotBgColor: backgroundLightColor,
                                borderRadius: true,
                                boxFit: BoxFit.cover,
                                autoplay: true,
                              )
                          ),*/
                          child: Swiper(
                            itemBuilder: (BuildContext context,int index){
                              return new Container(
                                margin: EdgeInsets.only(bottom: 30),
                                  child: Stack(
                                    alignment: Alignment.bottomLeft,
                                    children:  <Widget>[
                                      model.whatson[index].imageSource != null || model.whatson[index].imageSource != "" ?
                                      CachedNetworkImage(
                                        imageUrl: model.whatson[index].imageSource,
                                        fit: BoxFit.fill,
                                        width: MediaQuery.of(context).size.width,
                                        height: 150,
                                        placeholder: (context, url) => new SkeletonAnimation(
                                            child: Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                              ),
                                            )
                                        ),
                                        errorWidget: (context, url, error) => new Icon(Icons.error),
                                      ) :
                                      Container(
                                        height: 150,
                                        color: Colors.grey[300],
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: backgroundLightColor.withOpacity(0.8),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: <Widget>[
                                            Text(model.whatson[index].title != null ? model.whatson[index].title : "", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                              );
                            },
                            itemCount: model.whatson.length <= 3 ? model.whatson.length : 3,
                            pagination: new SwiperPagination(),
                            control: new SwiperControl(),
                            autoplay: true,
                            duration: 3,
                            containerHeight: 150,
                          ),
                        )
                    )
        );
  }
}
