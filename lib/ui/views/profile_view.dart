
import 'dart:io';

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/utility/app_utility.dart';
import 'package:iglo_world/core/viewmodels/home_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/bank_account_view.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/change_password_view.dart';
import 'package:iglo_world/ui/views/invite_friend_view.dart';
import 'package:iglo_world/ui/views/login_view.dart';
import 'package:iglo_world/ui/views/photo_viewer_view.dart';
import 'package:iglo_world/ui/views/profile_edit_view.dart';
import 'package:iglo_world/ui/views/reward_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/custom_toast_content_widget.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sweetalert/sweetalert.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  File _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;


  void _onImageButtonPressed(ImageSource source) async {
      try {
        _imageFile = await ImagePicker.pickImage(source: source);
      } catch (e) {
        _pickImageError = e;
      }
      if(_imageFile != null){
        await _cropImage();
      }
      setState(() {});
  }

  Future<Null> _cropImage() async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        aspectRatioPresets: Platform.isAndroid ? [CropAspectRatioPreset.square]
            : [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: backgroundLightColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            hideBottomControls: true,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          title: 'Crop Image',
        )
    );

    if (croppedFile != null) {
      _imageFile = croppedFile;
      setState((){});
    }else{
      _imageFile = null;
      setState((){});
    }
  }

  @override
  void initState() {
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
      onModelReady: (model) => model.getUserLogin(),
      builder: (context, model, child) =>
          Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomPadding: false,
            backgroundColor: Color.fromRGBO(243, 245, 248, 1),
            appBar: AppBarWidget(title: "Profile",
              scaffoldKey: _scaffoldKey,
              type: "text",),
            endDrawer: DrawerWidget(),
            body: model.user == null ? Center( child: ProfileViewSkeleton()) : ModalProgressHUD(
              inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
              child: SingleChildScrollView(
                child: Container(
                  color: Color(0xffEEEEEE),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: backgroundLightColor,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext bc){
                                      return Container(
                                        child: new Wrap(
                                          children: <Widget>[
                                            new ListTile(
                                                leading: new Icon(Icons.account_circle, color: backgroundLightColor,),
                                                title: new Text('View Photo Profile'),
                                                enabled: model.user[0].imageSource != null ? true : false,
                                                onTap: () {
                                                  if (model.user[0].imageSource != null) {
                                                    Navigator.pop(context);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PhotoViewerView(path: model.user[0].imageSource),
                                                        )
                                                    );
                                                  }
                                                }
                                            ),
                                            new ListTile(
                                              leading: new Icon(Icons.camera_alt, color: backgroundLightColor),
                                              title: new Text('Change Photo from Camera'),
                                              onTap: () async {
                                                Navigator.pop(context);
                                                await _onImageButtonPressed(ImageSource.camera);
                                                print(_imageFile);
                                                if(_imageFile != null){
                                                  var updatePhoto = await model.changeProfilePicture(_imageFile);
                                                  if (updatePhoto) {
                                                    showToastWidget(IconToastWidget.success(msg: "Successfully Update Profile Picture"),
                                                        context: context,
                                                        animation: StyledToastAnimation.slideFromBottom,
                                                        reverseAnimation: StyledToastAnimation.slideToBottom,
                                                        position: StyledToastPosition.center,
                                                        animDuration: Duration(seconds: 1),
                                                        duration: Duration(seconds: 4),
                                                        curve: Curves.elasticOut,
                                                        reverseCurve: Curves.fastOutSlowIn);
                                                    model.getUserLogin();
                                                    _imageFile = null;
                                                  }
                                                }
                                              },
                                            ),
                                            new ListTile(
                                              leading: new Icon(Icons.photo, color: backgroundLightColor),
                                              title: new Text('Change Photo from Galery'),
                                              onTap: () async {
                                                Navigator.pop(context);
                                                await _onImageButtonPressed(ImageSource.gallery);
                                                print(_imageFile);
                                                if(_imageFile != null){
                                                  var updatePhoto = await model.changeProfilePicture(_imageFile);
                                                  if (updatePhoto) {
                                                    showToastWidget(IconToastWidget.success(msg: "Successfully Update Profile Picture"),
                                                        context: context,
                                                        animation: StyledToastAnimation.slideFromBottom,
                                                        reverseAnimation: StyledToastAnimation.slideToBottom,
                                                        position: StyledToastPosition.center,
                                                        animDuration: Duration(seconds: 1),
                                                        duration: Duration(seconds: 4),
                                                        curve: Curves.elasticOut,
                                                        reverseCurve: Curves.fastOutSlowIn);
                                                    model.getUserLogin();
                                                    _imageFile = null;
                                                  }
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                );
                              },
                              child: Badge(
                                badgeColor: Colors.white,
                                shape: BadgeShape.circle,
                                borderRadius: 20,
                                padding: EdgeInsets.all(10),
                                toAnimate: false,
                                position: BadgePosition.bottomRight(right: 5, bottom: 5),
                                badgeContent: Icon(FontAwesomeIcons.camera, color: Colors.black, size: 16,),
                                child: ClipOval(
                                  child: model.user[0].imageSource == null ? Image.asset("assets/images/default_avatar.jpg", fit: BoxFit.fill, width: 150/*ScreenUtil().setWidth(400)*/, height: 150/*ScreenUtil().setHeight(400)*/,) :
                                  CachedNetworkImage(
                                    imageUrl: model.user[0].imageSource,
                                    fit: BoxFit.fill,
                                    width: 150,//ScreenUtil().setWidth(400),
                                    height: 150,//ScreenUtil().setHeight(400),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              model.user[0].fullName == null ? "" : model.user[0].fullName,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              model.user[0].email == null ? "" : model.user[0].email,
                              style: TextStyle(
                                  color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        )
                      ),
                      SizedBox(height: 10),
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
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.edit, color: backgroundLightColor, size: 16,),
                              SizedBox(width: 20,),
                              Text("Edit Profile", style: TextStyle()),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.chevronRight, size: 16,)
                                  ]
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangePasswordView(),
                              )
                          );
                        },
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.lock, color: backgroundLightColor, size: 16,),
                              SizedBox(width: 20),
                              Text("Change Password", style: TextStyle()),
                              Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.chevronRight, size: 16,)
                                    ]
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InviteFriendView(referralCode: model.user[0].referralCode,),
                              )
                          );
                        },
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.shareSquare, color: backgroundLightColor, size: 16,),
                              SizedBox(width: 20),
                              Text("Invite Friend", style: TextStyle()),
                              Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.chevronRight, size: 16,)
                                    ]
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyRewardView(),
                              )
                          );
                        },
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.gift, color: backgroundLightColor, size: 16,),
                              SizedBox(width: 20),
                              Text("My Rewards", style: TextStyle(),),
                              Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.chevronRight, size: 16,)
                                    ]
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BankAccountView(),
                              )
                          );
                        },
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.creditCard, color: backgroundLightColor, size: 16,),
                              SizedBox(width: 20),
                              Text("Bank Account", style: TextStyle(),),
                              Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.chevronRight, size: 16,)
                                    ]
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          SweetAlert.show(context,
                              //title: "Logout",
                              subtitle: "Are you sure logout this program ?",
                              style: SweetAlertStyle.confirm,
                              showCancelButton: true, onPress: (bool isConfirm) {
                                if (isConfirm) {
                                  prefs.remove('is_login');
                                  prefs.remove('user_id');
                                  prefs.remove('role_id');
                                  prefs.remove('full_name');
                                  prefs.remove('position_name');

                                  SweetAlert.show(context,subtitle: "Logout...", style: SweetAlertStyle.loading);
                                  new Future.delayed(new Duration(seconds: 1),(){
                                    SweetAlert.show(context,subtitle: "Success Logout!", style: SweetAlertStyle.success);
                                  });
                                  // return false to keep dialog
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(builder: (context) => LoginView()),
                                          (Route<dynamic> route) => false
                                  );
                                  return false;
                                }
                              });
                        },
                        child: Container(
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(20),
                          child: Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.signOutAlt, color: backgroundLightColor, size: 16,),
                              SizedBox(width: 20),
                              Text("Log Out", style: TextStyle(),),
                              Expanded(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Icon(FontAwesomeIcons.chevronRight, size: 16,)
                                    ]
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                ),
              ),
            ),
          ),
          ),
    );
  }
}



class ProfileViewSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Color(0xffEEEEEE),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                width: MediaQuery.of(context).size.width,
                color: backgroundLightColor,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    SkeletonAnimation(
                      child : Badge(
                        badgeColor: Colors.white,
                        shape: BadgeShape.circle,
                        borderRadius: 20,
                        padding: EdgeInsets.all(10),
                        toAnimate: false,
                        position: BadgePosition.bottomRight(right: 5, bottom: 5),
                        badgeContent: Icon(FontAwesomeIcons.camera, color: Colors.black,),
                        child: ClipOval(
                          child: Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    SkeletonAnimation(
                      child: Container(
                        height: 15,
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey[300]),
                      ),
                    ),
                    SizedBox(height: 5,),
                    SkeletonAnimation(
                      child: Container(
                        height: 15,
                        width: 400,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey[300]),
                      ),
                    ),
                    SizedBox(height: 20,),
                    //_imageFile != null ? Image.file(_imageFile) : Container(),
                  ],
                )
            ),
            SizedBox(height: 20,),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  SkeletonAnimation(
                    child: Container(
                      height: 15,
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
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  SkeletonAnimation(
                    child: Container(
                      height: 15,
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
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  SkeletonAnimation(
                    child: Container(
                      height: 15,
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
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  SkeletonAnimation(
                    child: Container(
                      height: 15,
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
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  SkeletonAnimation(
                    child: Container(
                      height: 15,
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
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  SkeletonAnimation(
                    child: Container(
                      height: 15,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[300]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}