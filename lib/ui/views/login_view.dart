import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iglo_world/core/utility/app_utility.dart';
import 'package:iglo_world/core/viewmodels/login_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/register_view.dart';
import 'package:iglo_world/ui/widgets/gradient_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iglo_world/core/enums/viewstate.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _screenUtilActive = true;

  void checkSessionLogin()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('is_login') ?? false;
    if(isLogin == true){
      Navigator.pushNamedAndRemoveUntil(context, '/', (route)=>false);
    }
  }

  @override
  void initState() {
    super.initState();
    checkSessionLogin();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      builder: (context, model, child) => Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.height,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/background_login.png", fit: BoxFit.cover, height: MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                "assets/images/logo.png",
                                width: 130,
                              ),
                              SizedBox(height: 30),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(right: 20, left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Username",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: AppUtility.textFieldHeight,
                                      child: TextField(
                                        controller: _usernameController,
                                        keyboardType: TextInputType.text,
                                        inputFormatters: [WhitelistingTextInputFormatter(new RegExp('[a-zA-Z0-9._]'))],
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Username',
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                        ),
                                        style: TextStyle(
                                          backgroundColor: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Password",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: AppUtility.textFieldHeight,
                                      child: TextField(
                                          controller: _passwordController,
                                          obscureText: model.hidePass,
                                          keyboardType: TextInputType.text,
                                        inputFormatters: [WhitelistingTextInputFormatter(new RegExp('[a-zA-Z0-9.]'))],
                                          autofocus: false,
                                          decoration: InputDecoration(
                                            hintText: 'Enter Password',
                                            filled: true,
                                            fillColor: Colors.white,
                                            prefixStyle: (
                                                TextStyle(
                                                  backgroundColor: Colors.white,
                                                  fontSize: 12,
                                                )
                                            ),
                                            contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0), borderSide: const BorderSide(color: Colors.white, width: 0.0)),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                model.hidePass
                                                    ? FontAwesomeIcons.eyeSlash
                                                    : FontAwesomeIcons.eye,
                                                color: Colors.black,
                                                size: 12,
                                              ),
                                              onPressed: () => model.changeHidePass(),
                                            ),
                                          ),
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                    ),
                                    SizedBox(height: 20),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        "Forgot Password ?",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    RaisedGradientButton(
                                        child: Text(
                                          'LOGIN',
                                          style: TextStyle(
                                              color: Colors.red, 
                                              fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[Color(0xffe8d322), Color(0xfffff3f3)],
                                        ),
                                        onPressed: () async {
                                          var loginSuccess = await model.login(
                                              _usernameController.text.trimLeft().trimRight(),
                                              _passwordController.text.trimLeft().trimRight());
                                          if (loginSuccess) {
                                            Navigator.pushNamedAndRemoveUntil(context, '/', (route)=>false);
                                          }
                                        }
                                    ),
                                    SizedBox(height: 15),
                                    RaisedGradientButton(
                                        child: Text(
                                          'REGISTER',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[backgroundDarkColor, backgroundDarkColor],
                                        ),
                                        onPressed: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => RegisterView(),
                                              )
                                          );
                                        }
                                    ),
                                    SizedBox(height: 32),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          color: backgroundDarkColor.withOpacity(0.7),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text("\u00a9 2020 by PT. Indocyber Global Teknologi", style: TextStyle(color: Colors.white)),
                                  )
                                ],
                              ),
                            ],
                          )
                        )
                      ],
                    )
                  ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}