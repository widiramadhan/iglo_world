import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/viewmodels/job_recomendation_viewmodel.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/empty_view.dart';
import 'package:iglo_world/ui/views/job_recomendation_detail_view.dart';
import 'package:iglo_world/ui/widgets/skeleton.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class JobRecomendationView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BaseView<JobRecomendationViewModel>(
        onModelReady: (model) => model.getJobRecomendation(),
        builder: (context, model, child) =>
            model.jobRecomendation == null ? Center( child: JobPositionSkeleton()) :
            ModalProgressHUD(
              inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Total Recomendation",
                          style: TextStyle(),
                        ),
                        SizedBox(width: 10),
                        Badge(
                          padding: EdgeInsets.all(8),
                          badgeContent: Text(model.jobRecomendation.length.toString(), style: TextStyle(color: Colors.red, fontSize: 10,)),
                          badgeColor: Colors.white,
                        )
                      ],
                    ),
                    SizedBox(width: 10,),
                    model.jobRecomendation.isEmpty ? EmptyDataView() : ListView.builder(
                        shrinkWrap: true,
                        itemCount: model.jobRecomendation.length,
                        controller: ScrollController(keepScrollOffset: false),
                        itemBuilder: (BuildContext context, int index) => Container(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => JobRecomendationDetailView(job_recomendation_id: model.jobRecomendation[index].recomendId,),
                                  )
                              );
                            },
                            child: Card(
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              "Full Name",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top:8),
                                            child: Text(
                                              "Apply for Position",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top:8),
                                            child: Text(
                                              "Apply Date",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              model.jobRecomendation[index].fullname != null ? model.jobRecomendation[index].fullname : "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top:8),
                                            child: Text(
                                              model.jobRecomendation[index].applyPosition != null ? model.jobRecomendation[index].applyPosition : "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top:8),
                                            child: Text(
                                              model.jobRecomendation[index].applyDate != null ? model.jobRecomendation[index].applyDate : "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          model.jobRecomendation[index].transactionId == 1 ? Image.asset("assets/images/ic_icon_submit.png", width: 30, height:30) :
                                          model.jobRecomendation[index].transactionId == 2 ? Image.asset("assets/images/ic_icon_review.png", width: 30, height:30) :
                                          model.jobRecomendation[index].transactionId == 3 ? Image.asset("assets/images/ic_icon_assessment.png", width: 30, height:30) :
                                          model.jobRecomendation[index].transactionId == 4 ? Image.asset("assets/images/ic_icon_offering.png", width: 30, height:30) :
                                          model.jobRecomendation[index].transactionId == 5 ? Image.asset("assets/images/ic_icon_finish.png", width: 30, height:30) :
                                          model.jobRecomendation[index].transactionId == 6 ? Image.asset("assets/images/ic_icon_result.png", width: 30, height:30) :
                                          model.jobRecomendation[index].transactionId == 7 ? Image.asset("assets/images/ic_icon_finish.png", width: 30, height:30) :
                                          Image.asset("assets/images/ic_icon_finish.png", width: 40, height: 40,),
                                          SizedBox(height: 10,),
                                          Text(model.jobRecomendation[index].transactionStatus, style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold,),textAlign: TextAlign.center,)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        )
                    ),
                  ],
                ),
              ),
            )
    );
  }
}