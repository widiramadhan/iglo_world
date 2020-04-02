import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:iglo_world/core/models/user.dart';
import 'package:iglo_world/core/viewmodels/base_viewmodel.dart';
import 'package:iglo_world/core/viewmodels/login_viewmodel.dart';
import 'package:iglo_world/locator.dart';
import 'package:iglo_world/ui/router.dart';
import 'package:iglo_world/ui/views/cropper_view.dart';
import 'package:provider/provider.dart';

import 'core/services/authentication_service.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //ScreenUtil.init(context, allowFontScaling: false);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        /*Provider<BaseViewModel>(
          create: (_) => BaseViewModel(),
        ),
        StreamProvider<User>(
          initialData: User.initial(),
          create: (context) => locator<AuthenticationService>().userController.stream,
        )*/
        ChangeNotifierProvider(
            builder: (context) => BaseViewModel(),
        )
      ],
      child: StyledToast(
        textStyle: TextStyle(fontSize: 12.0, color: Colors.white),
        backgroundColor: Color(0x99000000),
        borderRadius: BorderRadius.circular(5.0),
        textPadding: EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
        toastAnimation: StyledToastAnimation.slideFromBottomFade,
        reverseAnimation: StyledToastAnimation.slideToBottomFade,
        curve: Curves.bounceIn,
        reverseCurve: Curves.bounceOut,
        dismissOtherOnShow: true,
        movingOnWindowChange: true,
        child: MaterialApp(
          title: 'Iglo Wolrd',
          theme: ThemeData(
            primarySwatch: Colors.red,
            textTheme: TextTheme(body1: TextStyle(fontSize: 12))
          ),
          initialRoute: 'splash',
          onGenerateRoute: Router.generateRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
