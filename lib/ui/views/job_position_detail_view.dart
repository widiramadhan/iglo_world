
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/viewmodels/job_position_detail_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/job_apply_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:iglo_world/ui/widgets/gradient_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:share/share.dart';

class JobPositionDetailView extends StatefulWidget {
  String job_id;

  JobPositionDetailView({Key key, this.job_id});

  @override
  _JobPositionDetailViewState createState() => _JobPositionDetailViewState();
}

class _JobPositionDetailViewState extends State<JobPositionDetailView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<JobPositionDetailViewModel>(
      onModelReady: (model) => model.getJobPositionDetail(widget.job_id),
      builder: (context, model, child) =>
          Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomPadding: false,
            backgroundColor: Color.fromRGBO(243, 245, 248, 1),
            appBar: AppBarWidget(title: "Position Detail",
              scaffoldKey: _scaffoldKey,
              type: "text",),
            endDrawer: DrawerWidget(),
            body: model.jobPosition == null ? Center( child: CircularProgressIndicator()) : ModalProgressHUD(
              inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Card(
                              color: Colors.white,
                              elevation: 2,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                model.jobPosition[0].jobName != null ? model.jobPosition[0].jobName : "",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: backgroundLightColor,
                                                    fontSize: 14
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Text(
                                                model.jobPosition[0].jobType != null ? model.jobPosition[0].jobType : "",
                                                style: TextStyle(),
                                              ),
                                            ],
                                          )
                                        ),
                                        /*Expanded(
                                          flex: 1,
                                          child: Container(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Chip(
                                                  backgroundColor: backgroundLightColor,
                                                  padding: EdgeInsets.all(0),
                                                  label: Icon(Icons.map, color: Colors.white,),
                                                ),
                                              ],
                                            ),
                                          )
                                        )*/
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.calendar_today, size: 14, color: Colors.blue),
                                        SizedBox(width: 10,),
                                        Text(
                                          model.jobPosition[0].experience != null ? model.jobPosition[0].experience : "",
                                          style: TextStyle(),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: <Widget>[
                                        Icon(Icons.location_on, size: 14, color: Colors.blue),
                                        SizedBox(width: 10,),
                                        Text(
                                          model.jobPosition[0].location != null ? model.jobPosition[0].location : "",
                                          style: TextStyle(),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 30,),
                                    Text(
                                      "Job Description :",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      //textAlign: TextAlign.justify,
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            model.jobPosition[0].jobDescription != null ? model.jobPosition[0].jobDescription : "",
                                            //textAlign: TextAlign.justify,
                                            style: TextStyle(),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 30,),
                                    Text(
                                      "Job Requirement :",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      //textAlign: TextAlign.justify,
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            model.jobPosition[0].jobRequirment != null ? model.jobPosition[0].jobRequirment : "",
                                            //textAlign: TextAlign.justify,
                                            style: TextStyle(),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 30,),
                                    Center(
                                      child: InkWell(
                                        onTap: () {
                                          Share.share('check out my website https://example.com', subject: 'Look what I made!');
                                        },
                                        child: Icon(
                                          FontAwesomeIcons.shareAlt,
                                          color: backgroundLightColor,
                                          size: 30,
                                        ),
                                      )
                                    ),
                                    SizedBox(height: 10,),
                                    Center(
                                      child: Text(
                                        "Share",
                                        style: TextStyle(),
                                      ),
                                    ),
                                    SizedBox(height: 40,),
                                    RaisedGradientButton(
                                        child: Text(
                                          'I HAVE A REFERENCE',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, ),
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[backgroundLightColor, backgroundLightColor2],
                                        ),
                                        onPressed: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => JobApplyView(job_id: model.jobPosition[0].jobId,),
                                              )
                                          );
                                        }
                                    ),
                                    SizedBox(height: 20,),
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}