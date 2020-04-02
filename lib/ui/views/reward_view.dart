
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/viewmodels/home_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/job_recomendation_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/login_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/empty_view.dart';
import 'package:iglo_world/ui/views/job_recomendation_detail_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyRewardView extends StatefulWidget {
  @override
  _MyRewardViewState createState() => _MyRewardViewState();
}

class _MyRewardViewState extends State<MyRewardView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        onModelReady: (model) => model.getRewards(),
        builder: (context, model, child) => Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBarWidget(title: "My Rewards", scaffoldKey: _scaffoldKey, type: "text",),
          endDrawer: DrawerWidget(),
          body: model.reward == null ? Center(child: CircularProgressIndicator(),) : ModalProgressHUD(
              inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
              child: ListView.builder(
                itemCount: model.reward.length,
                shrinkWrap: true,
                controller: ScrollController(keepScrollOffset: false),
                itemBuilder: (BuildContext context, int index) => Container(
                  margin: EdgeInsets.only(left:10,right:10,top:5),
                  child: Column(
                    children: <Widget>[
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.cyan,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: Color(0xffacf1f6),
                                  ),
                                  child: Image.asset("assets/images/gift.png", width: 30, height: 30,),
                                )
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                flex: 3,
                                child:Container(
                                  width: MediaQuery.of(context).size.width - 130,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex:2,
                                            child: Text(model.reward[index].title != null ? model.reward[index].title : "", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                          ),
                                          Expanded(
                                              flex:1,
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Text(model.reward[index].rewardDateString != null ? model.reward[index].rewardDateString : "", style: TextStyle(color: Colors.white, fontSize: 10),),
                                              )
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Text(model.reward[index].description != null ? model.reward[index].description : "", style: TextStyle(color: Colors.white, fontSize: 10),),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: <Widget>[
                                          Text("Reward : ", style: TextStyle(color: Colors.white, fontSize: 10),),
                                          Text(model.reward[index].reward != null ? model.reward[index].reward : "", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),),
                                        ],
                                      )
                                    ],
                                  ),
                                ) ,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
              )
          ),
        )
      ),
    );
  }
}