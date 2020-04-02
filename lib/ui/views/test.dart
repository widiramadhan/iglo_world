
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/viewmodels/login_viewmodel.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class HelpView extends StatefulWidget {
  @override
  _HelpViewState createState() => _HelpViewState();
}

class _HelpViewState extends State<HelpView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
        builder: (context, model, child) => Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBarWidget(title: "Ask for Help", scaffoldKey: _scaffoldKey, type: "text",),
          endDrawer: DrawerWidget(),
          body: ModalProgressHUD(
          inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
            child: SingleChildScrollView(
              
            )
          ),
        )
    );
  }
}