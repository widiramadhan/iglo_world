
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/utility/app_utility.dart';
import 'package:iglo_world/core/viewmodels/home_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/login_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/invite_more_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:skeleton_text/skeleton_text.dart';

class InviteFriendView extends StatefulWidget {
  String referralCode;

  InviteFriendView({Key key, this.referralCode});

  @override
  _InviteFriendViewState createState() => _InviteFriendViewState();
}

class _InviteFriendViewState extends State<InviteFriendView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final double circleRadius = 100.0;
  final double circleBorderWidth = 8.0;

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        onModelReady: (model) => model.getInviteFriends(),
        builder: (context, model, child) => Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: AppBarWidget(title: "Invite Friend", scaffoldKey: _scaffoldKey, type: "text",),
          endDrawer: DrawerWidget(),
          body: model.inviteFriends == null ? Center( child: CircularProgressIndicator() ) : ModalProgressHUD(
          inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.cyan,
                      padding: EdgeInsets.all(50),
                      child: Column(
                        children: <Widget>[
                          Text("Share your Refferal code to your friends to use IGLO World and get rewards!", style: TextStyle(color: Colors.white,), textAlign: TextAlign.center,),
                          SizedBox(height: 30,),
                          Center(
                            child: Container(
                              width: 250,
                              height: 40,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(30))
                              ),
                              child: Center(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: Text(widget.referralCode != null || widget.referralCode != "" ? widget.referralCode : "", style: TextStyle(color: backgroundLightColor, fontWeight: FontWeight.bold),),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Icon(FontAwesomeIcons.shareAlt, color: backgroundLightColor, size: 16,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Invite your friends to get rewards !!",
                            style: TextStyle(fontWeight: FontWeight.bold,),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                  flex: 1,
                                  child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(10),
                                      child: model.inviteFriends.asMap()[0] != null ?
                                      UserApiWidget(filepath: model.inviteFriends[0].filePath, fullName: model.inviteFriends[0].fullName,)
                                          : UserDefaultWidget(number: "1",)
                                  )
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(10),
                                      child: model.inviteFriends.asMap()[1] != null ?
                                      UserApiWidget(filepath: model.inviteFriends[1].filePath, fullName: model.inviteFriends[1].fullName,)
                                          : UserDefaultWidget(number: "2",)
                                  )
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(10),
                                      child: model.inviteFriends.asMap()[2] != null ?
                                      UserApiWidget(filepath: model.inviteFriends[2].filePath, fullName: model.inviteFriends[2].fullName,)
                                          : UserDefaultWidget(number: "3",)
                                  )
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(10),
                                      child: model.inviteFriends.asMap()[3] != null ?
                                      UserApiWidget(filepath: model.inviteFriends[3].filePath, fullName: model.inviteFriends[3].fullName,)
                                          : UserDefaultWidget(number: "4",)
                                  )
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(10),
                                      child: model.inviteFriends.asMap()[4] != null ?
                                      UserApiWidget(filepath: model.inviteFriends[4].filePath, fullName: model.inviteFriends[4].fullName,)
                                          : UserDefaultWidget(number: "5",)
                                  )
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                  flex: 1,
                                  child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(10),
                                      child: model.inviteFriends.asMap()[5] != null ?
                                      UserApiWidget(filepath: model.inviteFriends[5].filePath, fullName: model.inviteFriends[5].fullName,)
                                          : UserDefaultWidget(number: "6",)
                                  )
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(10),
                                      child: model.inviteFriends.asMap()[6] != null ?
                                      UserApiWidget(filepath: model.inviteFriends[6].filePath, fullName: model.inviteFriends[6].fullName,)
                                          : UserDefaultWidget(number: "7",)
                                  )
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(10),
                                      child: model.inviteFriends.asMap()[7] != null ?
                                      UserApiWidget(filepath: model.inviteFriends[7].filePath, fullName: model.inviteFriends[7].fullName,)
                                          : UserDefaultWidget(number: "8",)
                                  )
                              ),
                              Flexible(
                                  flex: 1,
                                  child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(10),
                                      child: model.inviteFriends.asMap()[8] != null ?
                                      UserApiWidget(filepath: model.inviteFriends[8].filePath, fullName: model.inviteFriends[8].fullName,)
                                          : UserDefaultWidget(number: "9",)
                                  )
                              ),
                              model.inviteFriends.length < 10 ?
                              Flexible(
                                  flex: 1,
                                  child: Container(
                                      width: 100,
                                      padding: EdgeInsets.all(10),
                                      child: model.inviteFriends.asMap()[9] != null ?
                                      UserApiWidget(filepath: model.inviteFriends[9].filePath, fullName: model.inviteFriends[9].fullName,)
                                          : UserDefaultWidget(number: "10",)
                                  )
                              ) : Flexible(
                                  flex: 1,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => InviteMoreView(),
                                          )
                                      );
                                    },
                                    child: Container(
                                        width: 100,
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.black12,
                                              child: ClipOval(
                                                  child: //Image.asset("assets/images/default_user_add.jpg", fit: BoxFit.contain,)
                                                  Icon(Icons.more_horiz, color: Colors.white,)
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Text("See More", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.blue,),)
                                          ],
                                        )
                                    ),
                                  )
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            )
          ),
        )
    );
  }
}

class UserApiWidget extends StatelessWidget {
  String filepath, fullName;

  UserApiWidget({Key key, this.filepath, this.fullName});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: ClipOval(
            child: filepath == null || filepath == "" ? Image.asset("assets/images/default_avatar.jpg", fit: BoxFit.contain,)
                : CachedNetworkImage(
              imageUrl: filepath,
              fit: BoxFit.fill,
              placeholder: (context, url) => new SkeletonAnimation(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                    ),
                  )
              ),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(fullName != null ? fullName.split(' ')[0] : "", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.blue,),)
      ],
    );
  }
}

class UserDefaultWidget extends StatelessWidget {
  String number;

  UserDefaultWidget({Key key, this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.black12,
          child: ClipOval(
            child: //Image.asset("assets/images/default_user_add.jpg", fit: BoxFit.contain,)
            Icon(Icons.add, color: Colors.white,)
          ),
        ),
        SizedBox(height: 10),
        Text(number, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.blue,),)
      ],
    );
  }
}
