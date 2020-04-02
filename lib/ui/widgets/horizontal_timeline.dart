import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iglo_world/core/viewmodels/job_recomendation_detail_viewmodel.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HorizontalTimeline extends StatelessWidget {

  final int ticks;

  HorizontalTimeline({@required this.ticks});
  /*String transaction_id;

  HorizontalTimeline({Key key, this.transaction_id});*/


  @override
  Widget build(BuildContext context) {
    return BaseView<JobRecomendationDetailViewModel>(
        onModelReady: (model) => model.getTransactionStatus(),
        builder: (context, model, child) =>
        model.transactionStatus == null ? Center( child: CircularProgressIndicator()) :
        /*ListView.builder(
            shrinkWrap: true,
            //scrollDirection: Axis.horizontal,
            itemCount: 6,//model.transactionStatus.length,
            controller: ScrollController(keepScrollOffset: false),
            itemBuilder: (BuildContext context, int index) => Container(
                child: Column(
                  children: <Widget>[
                    model.transactionStatus[index].transactionStatusId == "1" ?
                        enabled == true ? Image.asset("assets/images/ic_icon_submit.png", fit: BoxFit.contain, height: 30,) : Image.asset("assets/images/ic_icon_submit_disabled.png", fit: BoxFit.contain, height: 30,)
                    :
                    model.transactionStatus[index].transactionStatusId == "2" ?
                      enabled == true ? Image.asset("assets/images/ic_icon_review.png", fit: BoxFit.contain, height: 30,) : Image.asset("assets/images/ic_icon_review_disabled.png", fit: BoxFit.contain, height: 30,)
                    :
                    model.transactionStatus[index].transactionStatusId == "3" ?
                      enabled == true ? Image.asset("assets/images/ic_icon_assessment.png", fit: BoxFit.contain, height: 30,) : Image.asset("assets/images/ic_icon_assessment_disabled.png", fit: BoxFit.contain, height: 30,)
                    :
                    model.transactionStatus[index].transactionStatusId == "4" ?
                      enabled == true ? Image.asset("assets/images/ic_icon_offering.png", fit: BoxFit.contain, height: 30,) : Image.asset("assets/images/ic_icon_offering_disabled.png", fit: BoxFit.contain, height: 30,)
                    :
                    model.transactionStatus[index].transactionStatusId == "5" ?
                      enabled == true ? Image.asset("assets/images/ic_icon_result.png", fit: BoxFit.contain, height: 30,) : Image.asset("assets/images/ic_icon_result_disabled.png", fit: BoxFit.contain, height: 30,)
                    :
                    model.transactionStatus[index].transactionStatusId == "7" ?
                      enabled == true ? Image.asset("assets/images/ic_icon_finish.png", fit: BoxFit.contain, height: 30,) : Image.asset("assets/images/ic_icon_finish_disabled.png", fit: BoxFit.contain, height: 30,) :
                    Image.asset("assets/images/ic_icon_finish.png", fit: BoxFit.contain, height: 30,)
                    ,
                    SizedBox(height: 5,),
                    Text(model.transactionStatus[index].transactionStatusName, style: TextStyle(fontSize: 10),maxLines: 1,overflow: TextOverflow.ellipsis,)
                  ],
                ),
            )
        )*/
          Row(
            children: <Widget>[
              //tick1(),
              Container(
                  width: 30,
                  child: Column(
                    children: <Widget>[
                      Image.asset("assets/images/ic_icon_submit.png", fit: BoxFit.contain, height: 30,),
                      SizedBox(height: 5,),
                      Text("Submit", style: TextStyle(fontSize: 10),maxLines: 1,overflow: TextOverflow.ellipsis,)
                    ],
                  )
              ),
              spacer(),
              line(),
              spacer(),
              Container(
                  width: 30,
                  child: Column(
                    children: <Widget>[
                      Image.asset("assets/images/ic_icon_review.png", fit: BoxFit.contain, height: 30,),
                      SizedBox(height: 5,),
                      Text("Review", style: TextStyle(fontSize: 10),maxLines: 1,overflow: TextOverflow.ellipsis,)
                    ],
                  )
              ),
              spacer(),
              line(),
              spacer(),
              Container(
                  width: 30,
                  child: Column(
                    children: <Widget>[
                      Image.asset("assets/images/ic_icon_assessment.png", fit: BoxFit.contain, height: 30,),
                      SizedBox(height: 5,),
                      Text("Assessment", style: TextStyle(fontSize: 10),maxLines: 1,overflow: TextOverflow.ellipsis,)
                    ],
                  )
              ),
              spacer(),
              line(),
              spacer(),
              Container(
                  width: 30,
                  child: Column(
                    children: <Widget>[
                      Image.asset("assets/images/ic_icon_offering.png", fit: BoxFit.contain, height: 30,),
                      SizedBox(height: 5,),
                      Text("Offering", style: TextStyle(fontSize: 10),maxLines: 1,overflow: TextOverflow.ellipsis,)
                    ],
                  )
              ),
              spacer(),
              line(),
              spacer(),
              Container(
                  width: 30,
                  child: Column(
                    children: <Widget>[
                      Image.asset("assets/images/ic_icon_result_disabled.png", fit: BoxFit.contain, height: 30,),
                      SizedBox(height: 5,),
                      Text("Result", style: TextStyle(fontSize: 10),maxLines: 1,overflow: TextOverflow.ellipsis,)
                    ],
                  )
              ),
              spacer(),
              line(),
              spacer(),
              Container(
                  width: 30,
                  child: Column(
                    children: <Widget>[
                      Image.asset("assets/images/ic_icon_finish_disabled.png", fit: BoxFit.contain, height: 30,),
                      SizedBox(height: 5,),
                      Text("Finish", style: TextStyle(fontSize: 10),maxLines: 1,overflow: TextOverflow.ellipsis,)
                    ],
                  )
              ),
            ],
          )
    );


  }

  Widget tick(bool isChecked){
    return isChecked?Icon(Icons.check_circle,color: Colors.blue,):Icon(Icons.radio_button_unchecked, color: Colors.blue,);
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
      width: 5.0,
    );
  }

  Widget line() {
    return Container(
      color: Color(0xffacf1f6),
      height: 5.0,
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
