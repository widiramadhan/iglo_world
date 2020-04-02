
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/viewmodels/login_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/issue_add_view.dart';
import 'package:iglo_world/ui/views/issue_closed_view.dart';
import 'package:iglo_world/ui/views/issue_open_view.dart';
import 'package:iglo_world/ui/views/issue_waiting_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:material_segmented_control/material_segmented_control.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HelpView extends StatefulWidget {
  @override
  _HelpViewState createState() => _HelpViewState();
}

const Color _colorOne = Color(0x33000000);
const Color _colorTwo = Color(0x24000000);
const Color _colorThree = Color(0x1F000000);

class _HelpViewState extends State<HelpView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Map<int, Widget> _children = {
    0: Text('New Issue', style: TextStyle(),),
    1: Text('On Progress', style: TextStyle(),),
    2: Text('Closed', style: TextStyle(),),
  };

  final Map<int, Widget> icons = <int, Widget>{
    0: IssueOpenView(),
    1: IssueWaitingView(),
    2: IssueClosedView(),
  };

  int _currentSelection = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        builder: (context, model, child) =>
            Scaffold(
              key: _scaffoldKey,
              backgroundColor: Color.fromRGBO(243, 245, 248, 1),
              appBar: AppBarWidget(title: "Employee Services",
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
                        Container(
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(243, 245, 248, 1),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40),
                                  topLeft: Radius.circular(40))
                          ),
                          child: icons[_currentSelection],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              floatingActionButton: _currentSelection == 0
                  ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IssueAddView(),
                      )
                  );
                },
                child: Icon(Icons.add),
                backgroundColor: backgroundLightColor,
              )
                  : null,
            )
    );
  }
}