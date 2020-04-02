import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iglo_world/core/viewmodels/home_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/help_view.dart';
import 'package:iglo_world/ui/views/job_position_view.dart';
import 'package:iglo_world/ui/views/profile_edit_view.dart';
import 'package:iglo_world/ui/views/profile_view.dart';
import 'package:iglo_world/ui/views/whatson_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/bod_slider.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:iglo_world/ui/widgets/open_position.dart';
import 'package:iglo_world/ui/widgets/whatson_slider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:skeleton_text/skeleton_text.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String spfUserType = "";

  getSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    spfUserType = prefs.getString('user_type');
  }

  @override
  void initState() {
    getSharedPreferences();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      onModelReady: (model) => model.getAll(),
      builder: (context, model, child) => Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBarWidget(title: "", scaffoldKey: _scaffoldKey, type: "image",),
        endDrawer: DrawerWidget(),
        body: model.issue == null || model.user == null || model.bod == null || model.whatson == null || model.jobPosition == null ? Center( child: HomeViewSkeleton()) : ModalProgressHUD(
          inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
          child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    color: backgroundLightColor,
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        //===== START CARD PROFILE =====//
                        Container(
                            //padding: EdgeInsets.only(left: 15, right: 15, top:20, bottom: 20),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(8))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      child: Column(
                                        children: <Widget>[
                                          InkWell(
                                            onTap: (){
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => ProfileView(),
                                                  )
                                              );
                                            },
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.white,
                                              child: ClipOval(
                                                child: model.user[0].imageSource == null ? Image.asset("assets/images/default_avatar.jpg", fit: BoxFit.fill) :
                                                CachedNetworkImage(
                                                  imageUrl: model.user[0].imageSource,
                                                  fit: BoxFit.fill,
                                                  placeholder: (context, url) => new SkeletonAnimation(
                                                    child: Container(
                                                      width: 70,
                                                      height: 70,
                                                      decoration: BoxDecoration(
                                                        color: Colors.grey[300],
                                                      ),
                                                    )
                                                  ),
                                                  errorWidget: (context, url, error) => new Icon(Icons.error),
                                                ),
                                              ),
                                            )
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Welcome,",
                                          style: TextStyle(),
                                        ),
                                        SizedBox(height: 5,),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              model.user[0].fullName == null ? "" : model.user[0].fullName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: backgroundLightColor
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            InkWell(
                                              onTap: (){
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ProfileEditView(
                                                        fullname: model.user[0].fullName,
                                                        email: model.user[0].email,
                                                        phone: model.user[0].phoneNumber,
                                                        address: model.user[0].address,
                                                        company: model.user[0].company,
                                                      ),
                                                    )
                                                );
                                              },
                                              child: Icon(
                                                FontAwesomeIcons.edit,
                                                size: 14,
                                                color: Colors.grey,
                                              )
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Visibility(
                                          child: InkWell(
                                            onTap: (){
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => HelpView(),
                                                  )
                                              );
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  "Open Tickets : ",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontStyle: FontStyle.italic
                                                  ),
                                                ),
                                                Badge(
                                                  padding: EdgeInsets.all(5),
                                                  badgeContent: Text(model.issue.length.toString(), style: TextStyle(color: Colors.white, fontSize: 7)),
                                                  badgeColor: backgroundLightColor,
                                                )
                                              ],
                                            ),
                                          ),
                                          visible: spfUserType == "External" ? false : true,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ]
                          ),
                        ),
                        //===== END CARD PROFILE =====//
                        SizedBox(height: 20,),
                        //===== START QUOTES FROM BOD =====//
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Greetings from Our BoD",
                                style: TextStyle(
                                    color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10,),
                              BODView()
                            ],
                          )
                        ),
                        //===== END QUOTES FROM BOD =====//
                      ],
                    ),
                  ),
                  //===== START WHATS ON =====//
                  Container(
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "What's On",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => WhatsOnView()
                                            )
                                        );
                                      },
                                      child: Chip(
                                        backgroundColor: backgroundLightColor,
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                        label: Text('Show All', style: TextStyle(color: Colors.white, fontSize: 10)),
                                      ),
                                    )
                                  ],
                                )
                              )
                            )
                          ],
                        ),
                        WhatsOnSlider()
                      ],
                    ),
                  ),
                  //===== END WHATS ON =====//
                  //SizedBox(height: 10,),
                  //===== START JOB =====//
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10, right: 10, left: 10),
                      child: Text(
                        "Recommend your Reference to get a reward!",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    )
                  ),
                  SizedBox(height: 10,),
                  Container(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(243, 245, 248, 1),
                            borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40))
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    "All Open Position",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            InkWell(
                                              onTap: (){
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => JobPositionView(),
                                                    )
                                                );
                                              },
                                              child: Chip(
                                                backgroundColor: backgroundLightColor,
                                                padding: EdgeInsets.only(left: 10, right: 10),
                                                label: Text('Show All', style: TextStyle(color: Colors.white, fontSize: 10)),
                                              ),
                                            )
                                          ],
                                        )
                                    )
                                )
                              ],
                            ),
                            OpenPosition(),
                          ],
                        )
                      ),
                  ),
                  //===== END JOB =====//
                ],
              )
          ),
        ),
      ),
    );
  }
}





class HomeViewSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: backgroundLightColor,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //===== START CARD PROFILE =====//
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      SkeletonAnimation(
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.white,
                                            child: ClipOval(
                                              child: Container(
                                                width: 70,
                                                height: 70,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                ),
                                              ),
                                            ),
                                          )
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                flex:3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                ),
                              )
                            ],
                          ),
                        ]
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(70))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundColor: Colors.white,
                                              child: ClipOval(
                                                child: Container(
                                                  width: 70,
                                                  height: 70,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            child: SkeletonAnimation(
                                              child: Container(
                                                height: 12,
                                                width: MediaQuery.of(context).size.width,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    color: Colors.grey[300]),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            child: SkeletonAnimation(
                                              child: Container(
                                                height: 12,
                                                width: MediaQuery.of(context).size.width,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    color: Colors.grey[300]),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10,),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.6,
                                            child: SkeletonAnimation(
                                              child: Container(
                                                height: 12,
                                                width: MediaQuery.of(context).size.width,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                    color: Colors.grey[300]),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ]
                          ),
                        ),
                      ]
                    )
                  ),
                ],
              ),
            ),
            //===== START WHATS ON =====//
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[300]),
                    ),
                  )
                ],
              ),
            ),
            //===== END WHATS ON =====//
            SizedBox(height: 10,),
            //===== START JOB =====//
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: Container(
                  padding: EdgeInsets.all(10,),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(243, 245, 248, 1),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40))
                  ),
                  child: Column(
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
                      SizedBox(width: 10,),
                      Card(
                        margin: EdgeInsets.only(top: 10, bottom: 10,),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10,),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(top: 10, bottom: 10,),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10,),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(top: 10, bottom: 10,),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                  ],
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
              ),
            ),
            //===== END JOB =====//
          ],
        )
    );
  }
}