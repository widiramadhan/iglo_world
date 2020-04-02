import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemCount: 10,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                color: Colors.white70),
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SkeletonAnimation(
                    child: Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 15.0, bottom: 5.0),
                        child: SkeletonAnimation(
                          child: Container(
                            height: 15,
                            width: MediaQuery.of(context).size.width * 0.6,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey[300]),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: SkeletonAnimation(
                            child: Container(
                              width: 60,
                              height: 13,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
  }
}

class NotificationSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color.fromRGBO(243, 245, 248, 1),
        padding: EdgeInsets.all(20),
        child: Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SkeletonAnimation(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[300]),
                          )
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: <Widget>[
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 19,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SkeletonAnimation(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[300]),
                          )
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: <Widget>[
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SkeletonAnimation(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[300]),
                          )
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: <Widget>[
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SkeletonAnimation(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[300]),
                          )
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: <Widget>[
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SkeletonAnimation(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[300]),
                          )
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: <Widget>[
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SkeletonAnimation(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[300]),
                          )
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: <Widget>[
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SkeletonAnimation(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[300]),
                          )
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: <Widget>[
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SkeletonAnimation(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[300]),
                          )
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: <Widget>[
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SkeletonAnimation(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[300]),
                          )
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: <Widget>[
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SkeletonAnimation(
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.grey[300]),
                          )
                      ),
                      SizedBox(width: 10),
                      Column(
                        children: <Widget>[
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                          SizedBox(height: 10,),
                          SkeletonAnimation(
                            child: Container(
                              height: 12,
                              width: MediaQuery.of(context).size.width * 0.6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.grey[300]),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}


class JobPositionSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color.fromRGBO(243, 245, 248, 1),
        padding: EdgeInsets.all(20),
        child: Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}


class IssueSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color.fromRGBO(243, 245, 248, 1),
        padding: EdgeInsets.all(20),
        child: Column(
            children: <Widget>[
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.only(top: 7, bottom: 7),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      ),
                      SizedBox(width: 10),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                              SizedBox(height: 10,),
                              SkeletonAnimation(
                                child: Container(
                                  height: 12,
                                  //width: MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[300]),
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                ),
              ),
            ]
        ),
      ),
    );
  }
}