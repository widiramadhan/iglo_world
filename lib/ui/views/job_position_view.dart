
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/viewmodels/job_position_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/job_open_position_view.dart';
import 'package:iglo_world/ui/views/job_recomendation_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class JobPositionView extends StatefulWidget {
  @override
  _JobPositionViewState createState() => _JobPositionViewState();
}

class _JobPositionViewState extends State<JobPositionView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Map<int, Widget> _children = {
    0: Text('All Open Position', style: TextStyle(fontSize: 12),),
    1: Text('My Recomendation', style: TextStyle(fontSize: 12),),
  };

  final Map<int, Widget> icons = <int, Widget>{
    0: JobOpenPositionView(),
    1: JobRecomendationView(),
  };

  int _currentSelection = 0;

  @override
  Widget build(BuildContext context) {
    return BaseView<JobPositionViewModel>(
        builder: (context, model, child) =>
            Scaffold(
              key: _scaffoldKey,
              backgroundColor: Color.fromRGBO(243, 245, 248, 1),
              appBar: AppBarWidget(title: "Job Position",
                scaffoldKey: _scaffoldKey,
                type: "text",),
              endDrawer: DrawerWidget(),
              body: ModalProgressHUD(
                inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(20),
                            child: MaterialSegmentedControl(
                              children: _children,
                              selectionIndex: _currentSelection,
                              borderColor: Colors.grey,
                              selectedColor: backgroundLightColor,
                              unselectedColor: Colors.white,
                              borderRadius: 32.0,
                              onSegmentChosen: (index) {
                                setState(() {
                                  _currentSelection = index;
                                });
                              },
                            )
                        ),
                        Text(
                          "You will get a reward when the status is done",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          padding:EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(243, 245, 248, 1),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  topLeft: Radius.circular(40)),
                          ),
                          child: icons[_currentSelection],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
    );
  }
}