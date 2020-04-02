
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/viewmodels/job_recomendation_detail_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:iglo_world/ui/widgets/horizontal_timeline.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:skeleton_text/skeleton_text.dart';

class JobRecomendationDetailView extends StatefulWidget {
  String job_recomendation_id;

  JobRecomendationDetailView({Key key, this.job_recomendation_id});

  @override
  _JobRecomendationDetailViewState createState() => _JobRecomendationDetailViewState();
}

class _JobRecomendationDetailViewState extends State<JobRecomendationDetailView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  /*final formatDate = new DateFormat('yyyy-MM-dd');

  final List<TimelineModel> list = [
    TimelineModel(
        id: "1",
        description: "",
        title: "Success Submit"),
    TimelineModel(
        id: "2",
        description: "CV Reviewed by Michael",
        title: "Reviewed"),
    TimelineModel(
        id: "3",
        description: "Recruiter Interview by Siti\nTechnical Interview by Head Departement",
        title: "Assessment"),
    TimelineModel(
        id: "4",
        description: "",
        title: "Offering Progress")
  ];*/

  @override
  Widget build(BuildContext context) {
    return BaseView<JobRecomendationDetailViewModel>(
      onModelReady: (model) => model.getJobRecomendationDetail(widget.job_recomendation_id),
      builder: (context, model, child) =>
          Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomPadding: false,
            backgroundColor: Color.fromRGBO(243, 245, 248, 1),
            appBar: AppBarWidget(title: "Application Detail",
              scaffoldKey: _scaffoldKey,
              type: "text",),
            endDrawer: DrawerWidget(),
            body: model.jobRecomendationDetail == null ? Center( child: CircularProgressIndicator()) : ModalProgressHUD(
              inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
              child: SingleChildScrollView(
                child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Text(
                                        "Fullname",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Text(
                                        model.jobRecomendationDetail[0].fullname != null ? model.jobRecomendationDetail[0].fullname : "",
                                        style: TextStyle(
                                        ),/*maxLines: 1,
                                      overflow: TextOverflow.ellipsis,*/
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Text(
                                        "Apply For Position",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Text(
                                        model.jobRecomendationDetail[0].applyPosition != null ? model.jobRecomendationDetail[0].applyPosition : "",
                                        style: TextStyle(
                                        ),/*maxLines: 1,
                                      overflow: TextOverflow.ellipsis,*/
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Text(
                                        "Apply Date",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Text(
                                        model.jobRecomendationDetail[0].applyDate != null ? model.jobRecomendationDetail[0].applyDate : "",
                                        style: TextStyle(
                                        ),/*maxLines: 1,
                                      overflow: TextOverflow.ellipsis,*/
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Text(
                                        "Email",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Text(
                                        model.jobRecomendationDetail[0].email != null ? model.jobRecomendationDetail[0].email : "",
                                        style: TextStyle(
                                        ),/*maxLines: 1,
                                      overflow: TextOverflow.ellipsis,*/
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Text(
                                        "Phone",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Text(
                                        model.jobRecomendationDetail[0].phone != null ? model.jobRecomendationDetail[0].phone : "",
                                        style: TextStyle(
                                        ),/*maxLines: 1,
                                      overflow: TextOverflow.ellipsis,*/
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Text(
                                        "Status",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      child: Text(
                                        model.jobRecomendationDetail[0].transactionStatus != null ? model.jobRecomendationDetail[0].transactionStatus : "",
                                        style: TextStyle(
                                        ),/*maxLines: 1,
                                      overflow: TextOverflow.ellipsis,*/
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Track your Application.",
                                style: TextStyle(
                                    color: backgroundBlueColor,
                                    fontSize: 14
                                ),
                              ),
                              SizedBox(height: 30,),

                              Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    //tick1(),
                                    Container(
                                        width: 35,
                                        child: Column(
                                          children: <Widget>[
                                            model.jobRecomendationDetail[0].transactionStatusId == 5 ?
                                              Image.asset("assets/images/ic_icon_submit_disabled.png", fit: BoxFit.contain, height: 30,) :
                                            Image.asset("assets/images/ic_icon_submit.png", fit: BoxFit.contain, height: 30,),
                                            SizedBox(height: 5),
                                            Text("Submitted", style: TextStyle(fontSize: 7),maxLines: 1,overflow: TextOverflow.ellipsis,)
                                          ],
                                        )
                                    ),
                                    spacer(),
                                    line(),
                                    spacer(),
                                    Container(
                                        width:35,
                                        child: Column(
                                          children: <Widget>[
                                            model.jobRecomendationDetail[0].transactionStatusId == 5 ?
                                            Image.asset("assets/images/ic_icon_review_disabled.png", fit: BoxFit.contain, height: 30,) :
                                            model.jobRecomendationDetail[0].transactionStatusId >= 2 ?
                                            Image.asset("assets/images/ic_icon_review.png", fit: BoxFit.contain, height: 30,) :
                                            Image.asset("assets/images/ic_icon_review_disabled.png", fit: BoxFit.contain, height: 30,) ,
                                            SizedBox(height: 5,),
                                            Text("Reviewed", style: TextStyle(fontSize: 7),maxLines: 1,overflow: TextOverflow.ellipsis,)
                                          ],
                                        )
                                    ),
                                    spacer(),
                                    line(),
                                    spacer(),
                                    Container(
                                        width: 35,
                                        child: Column(
                                          children: <Widget>[
                                            model.jobRecomendationDetail[0].transactionStatusId == 5 ?
                                            Image.asset("assets/images/ic_icon_assessment_disabled.png", fit: BoxFit.contain, height: 30,) :
                                            model.jobRecomendationDetail[0].transactionStatusId >= 3 ?
                                            Image.asset("assets/images/ic_icon_assessment.png", fit: BoxFit.contain, height: 30,) :
                                            Image.asset("assets/images/ic_icon_assessment_disabled.png", fit: BoxFit.contain, height: 30,) ,
                                            SizedBox(height: 5,),
                                            Text("Assessed", style: TextStyle(fontSize: 7),maxLines: 1,overflow: TextOverflow.ellipsis,)
                                          ],
                                        )
                                    ),
                                    spacer(),
                                    line(),
                                    spacer(),
                                    Container(
                                        width: 35,
                                        child: Column(
                                          children: <Widget>[
                                            model.jobRecomendationDetail[0].transactionStatusId == 5 ?
                                            Image.asset("assets/images/ic_icon_offering_disabled.png", fit: BoxFit.contain, height: 30,) :
                                            model.jobRecomendationDetail[0].transactionStatusId >= 4 ?
                                            Image.asset("assets/images/ic_icon_offering.png", fit: BoxFit.contain, height: 30,) :
                                            Image.asset("assets/images/ic_icon_offering_disabled.png", fit: BoxFit.contain, height: 30,) ,
                                            SizedBox(height: 5,),
                                            Text("Offering", style: TextStyle(fontSize: 7),maxLines: 1,overflow: TextOverflow.ellipsis,)
                                          ],
                                        )
                                    ),
                                    spacer(),
                                    line(),
                                    spacer(),
                                    Container(
                                        width: 35,
                                        child: Column(
                                          children: <Widget>[
                                            model.jobRecomendationDetail[0].transactionStatusId == 5 ?
                                            Image.asset("assets/images/ic_icon_result_disabled.png", fit: BoxFit.contain, height: 30,) :
                                            model.jobRecomendationDetail[0].transactionStatusId != 5 && model.jobRecomendationDetail[0].transactionStatusId >= 6 ?
                                            Image.asset("assets/images/ic_icon_result.png", fit: BoxFit.contain, height: 30,) :
                                            Image.asset("assets/images/ic_icon_result_disabled.png", fit: BoxFit.contain, height: 30,) ,
                                            SizedBox(height: 5,),
                                            Text("Hired", style: TextStyle(fontSize: 7),maxLines: 1,overflow: TextOverflow.ellipsis,)
                                          ],
                                        )
                                    ),
                                    spacer(),
                                    line(),
                                    spacer(),
                                    Container(
                                        width: 35,
                                        child: Column(
                                          children: <Widget>[
                                            model.jobRecomendationDetail[0].transactionStatusId == 5 ?
                                            Image.asset("assets/images/ic_icon_finish_disabled.png", fit: BoxFit.contain, height: 30,) :
                                            model.jobRecomendationDetail[0].transactionStatusId != 5 && model.jobRecomendationDetail[0].transactionStatusId >= 7 ?
                                            Image.asset("assets/images/ic_icon_finish.png", fit: BoxFit.contain, height: 30,) :
                                            Image.asset("assets/images/ic_icon_finish_disabled.png", fit: BoxFit.contain, height: 30,) ,
                                            SizedBox(height: 5,),
                                            Text("Closed", style: TextStyle(fontSize: 7),maxLines: 1,overflow: TextOverflow.ellipsis,)
                                          ],
                                        )
                                    ),
                                  ],
                                )
                              ),



                              SizedBox(height: 30,),
                              Text(
                                "History",
                                style: TextStyle(
                                  color: backgroundBlueColor,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 10,),

                              model.jobRecomendationHistory == null ? Container( child: Text("No data history", style: TextStyle(fontSize: 14),),) :
                              ListView.builder(
                                itemCount: model.jobRecomendationHistory.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return new Stack(
                                    children: <Widget>[
                                      new Padding(
                                        padding: const EdgeInsets.only(left: 40.0),
                                        child: new Container(
                                          margin: new EdgeInsets.all(0.0),
                                          child: new Container(
                                            width: double.infinity,
                                            height: 70.0,
                                            color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Text(model.jobRecomendationHistory[index].timestamp, style: TextStyle(color: backgroundBlueColor, fontStyle: FontStyle.italic, ),)
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Text(model.jobRecomendationHistory[index].statusName, style: TextStyle(fontWeight: FontWeight.bold, ),),
                                                  ],
                                                ),
                                                Visibility(
                                                  child: Column(
                                                    children: <Widget>[
                                                      SizedBox(height: 5,),
                                                      Text(model.jobRecomendationHistory[index].descriptionResult, style: TextStyle(fontStyle: FontStyle.italic, ),overflow: TextOverflow.ellipsis, maxLines: 2,),
                                                    ],
                                                  ),
                                                  visible: model.jobRecomendationHistory[index].descriptionResult != "null" ? true : false,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      new Positioned(
                                        top: 0.0,
                                        bottom: 0.0,
                                        left: 15.0,
                                        child: new Container(
                                          height: double.infinity,
                                          width: 1.0,
                                          color: backgroundBlueColor,
                                        ),
                                      ),
                                      new Positioned(
                                        top: 5.0,
                                        left: 0.0,
                                        child: new Container(
                                          height: 30.0,
                                          width: 30.0,
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: new Container(
                                            margin: new EdgeInsets.all(5.0),
                                            height: 30.0,
                                            width: 30.0,
                                            decoration: new BoxDecoration(
                                                shape: BoxShape.circle
                                                ,border: Border.all(color: backgroundBlueColor, width: 3),
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),

                              SizedBox(height: 10,),
                              /*Timeline(
                                children: <Widget>[
                                  //Container(height: 100, color: Colors.red),
                                  Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("Sucess Submited", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                                  ],
                                                )
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text("08 Nov 2019", style: TextStyle(fontSize: 16, color: backgroundBlueColor,),)
                                                  ],
                                                )
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("Reviewed", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                                    SizedBox(height:8),
                                                    Text("CV reviewed by Michael", style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),),
                                                  ],
                                                )
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text("12 Dec 2019", style: TextStyle(fontSize: 16, color: backgroundBlueColor,),)
                                                  ],
                                                )
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("Assessment", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                                    SizedBox(height:8),
                                                    Text("Recruiter interview by Siti", style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),),
                                                    Text("Technical interview by Head Departement", style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),),
                                                  ],
                                                )
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text("15 Dec 2019", style: TextStyle(fontSize: 16, color: backgroundBlueColor,),)
                                                  ],
                                                )
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text("Offering Progress", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                                  ],
                                                )
                                            ),
                                            Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    Text("24 Dec 2019", style: TextStyle(fontSize: 16, color: backgroundBlueColor,),)
                                                  ],
                                                )
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                                indicators: <Widget>[
                                  *//*Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Icon(FontAwesomeIcons.circle, color: backgroundBlueColor,),
                                      ],
                                    ),
                                  ),*//*
                                  Icon(FontAwesomeIcons.circle, color: backgroundBlueColor,),
                                  Icon(FontAwesomeIcons.circle, color: backgroundBlueColor,),
                                  Icon(FontAwesomeIcons.circle, color: backgroundBlueColor,),
                                  Icon(FontAwesomeIcons.circle, color: backgroundBlueColor,),
                                ],
                              ),*/
                            ],
                          ),
                        ),
                      ],
                    )
                ),
              ),
            ),
          ),
    );
  }

  Widget tick(bool isChecked){
    return isChecked?Icon(Icons.check_circle,color: backgroundBlueColor,):Icon(Icons.radio_button_unchecked, color: backgroundBlueColor,);
  }

  Widget tick1() {
    //return this.ticks>0?tick(true):tick(false);
    return tick(true);
  }
  Widget tick2() {
    //return this.ticks>1?tick(true):tick(false);
    return tick(true);
  }
  Widget tick3() {
    //return this.ticks>2?tick(true):tick(false);
    return tick(true);
  }
  Widget tick4() {
    //return this.ticks>3?tick(true):tick(false);
    return tick(true);
  }

  Widget spacer() {
    return Container(
      //width: 5.0,
      width: 0.0,
    );
  }

  Widget line() {
    return Container(
      color: Color(0xffacf1f6),
      height: 3.0,
      width: 20.0,
      margin: EdgeInsets.only(bottom:10),
    );
  }
}

class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return HorizontalTimeline(ticks: 3,);
  }
}


class Loading extends StatelessWidget {
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

