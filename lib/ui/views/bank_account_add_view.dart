
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/services/api.dart';
import 'package:iglo_world/core/utility/app_utility.dart';
import 'package:iglo_world/core/viewmodels/home_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/bank_account_view.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/custom_toast_content_widget.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:iglo_world/ui/widgets/gradient_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddBankView extends StatefulWidget {
  @override
  _AddBankViewState createState() => _AddBankViewState();
}

class _AddBankViewState extends State<AddBankView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _txtAccountName = TextEditingController();
  final TextEditingController _txtAccountNumber = TextEditingController();

  String _valueBank;
  List listBank = List();

  Future<String> getListBank() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String spfToken = prefs.getString('token') ?? '';

    var res = await http.get(Uri.encodeFull(Api.endpoint+"/Bank/GetListBank"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $spfToken"
        });
    var resBody = json.decode(res.body)['data'];
    setState(() {
      listBank = resBody;
    });
    return "Sucess";
  }

  DropdownButton _dropdownListBank() => DropdownButton(
    hint: new Text("Select Bank", style: TextStyle(fontSize: 10),),
    items: listBank.map((item) {
      return new DropdownMenuItem(
        value: item['id'].toString() != null ? item['id'].toString() : "",
        child: new Text(item['name'] != null ? item['name'] : "", maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 10,),),
      );
    }).toList(),
    onChanged: (newVal) {
      setState(() {
        _valueBank = newVal;
      });
    },
    value: _valueBank,
  );


  @override
  void initState() {
    super.initState();
    this.getListBank();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (context, model, child) =>
          Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomPadding: false,
            backgroundColor: Color.fromRGBO(243, 245, 248, 1),
            appBar: AppBarWidget(title: "Add Bank Account",
              scaffoldKey: _scaffoldKey,
              type: "text",),
            endDrawer: DrawerWidget(),
            body: ModalProgressHUD(
              inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
              child: listBank.isEmpty ? Center( child:CircularProgressIndicator()) : SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Card(
                              color: Colors.white,
                              elevation: 5,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "Account Name",
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          " * ",
                                          style: TextStyle(
                                              color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 40,
                                      child: TextField(
                                        controller: _txtAccountName,
                                        keyboardType: TextInputType.text,
                                        inputFormatters: [WhitelistingTextInputFormatter(new RegExp('[a-zA-Z ]'))],
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Account Name',
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide: const BorderSide(color: Colors.white, width: 0.0)),
                                        ),
                                        style: TextStyle(
                                          backgroundColor: Colors.white,
                                          fontSize: 12
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "Bank Account",
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          " * ",
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 40,
                                      padding: EdgeInsets.only(right: 10, left: 10),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(32),
                                          border: Border.all(color: Colors.grey)
                                      ),
                                      child: DropdownButtonHideUnderline(child: _dropdownListBank()),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "Account Number",
                                          style: TextStyle(),
                                        ),
                                        Text(
                                          " * ",
                                          style: TextStyle(
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 40,
                                      child: TextField(
                                        controller: _txtAccountNumber,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [WhitelistingTextInputFormatter(new RegExp('[0-9]'))],
                                        autofocus: false,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Account Number',
                                          filled: true,
                                          fillColor: Colors.white,
                                          contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide: const BorderSide(color: Colors.white, width: 0.0)),
                                        ),
                                        style: TextStyle(
                                          backgroundColor: Colors.white,
                                          fontSize: 12
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    RaisedGradientButton(
                                        child: Text(
                                          'SUBMIT',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
                                        ),
                                        gradient: LinearGradient(
                                          colors: <Color>[backgroundLightColor, backgroundLightColor2],
                                        ),
                                        onPressed: () async {
                                          var submitSuccess = await model.submitBankAccount(
                                              _txtAccountName.text,
                                              _valueBank,
                                              _txtAccountNumber.text);
                                          if (submitSuccess) {
                                            //showToast("Successfully Add Bank Account");
                                            showToastWidget(IconToastWidget.success(msg: "Successfully Add Bank Account"),
                                                context: context,
                                                animation: StyledToastAnimation.slideFromBottom,
                                                reverseAnimation: StyledToastAnimation.slideToBottom,
                                                position: StyledToastPosition.center,
                                                animDuration: Duration(seconds: 1),
                                                duration: Duration(seconds: 4),
                                                curve: Curves.elasticOut,
                                                reverseCurve: Curves.fastOutSlowIn);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => BankAccountView(),
                                                )
                                            );
                                          }
                                        }
                                    ),
                                    SizedBox(height: 20,),
                                  ],
                                ),
                              )
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}