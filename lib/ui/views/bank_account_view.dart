
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/utility/app_utility.dart';
import 'package:iglo_world/core/viewmodels/home_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/bank_account_add_view.dart';
import 'package:iglo_world/ui/views/bank_account_edit_view.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/widgets/app_bar.dart';
import 'package:iglo_world/ui/widgets/drawer.dart';
import 'package:iglo_world/ui/widgets/gradient_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class BankAccountView extends StatefulWidget {
  @override
  _BankAccountViewState createState() => _BankAccountViewState();
}

class _BankAccountViewState extends State<BankAccountView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        onModelReady: (model) => model.getBankAccount(),
        builder: (context, model, child) => Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color.fromRGBO(243, 245, 248, 1),
          appBar: AppBarWidget(title: "Bank Account", scaffoldKey: _scaffoldKey, type: "text",),
          endDrawer: DrawerWidget(),
          body: model.bankAccount == null ? Center( child: CircularProgressIndicator()) : ModalProgressHUD(
          inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
            child: model.bankAccount.isEmpty ? Center(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/images/empty.png", width: 300, height: 300),
                      SizedBox(height: 10,),
                      Text("There is no data on this page\nplease add bank account", style: TextStyle(color: backgroundLightColor, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      SizedBox(height: 30,),
                      RaisedGradientButton(
                        width:400,
                        child: Text(
                          'ADD BANK ACCOUNT',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),
                        ),
                        gradient: LinearGradient(
                          colors: <Color>[backgroundLightColor, backgroundLightColor2],
                        ),
                        onPressed: () async {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddBankView(),
                              )
                          );
                        }
                      ),
                    ],
                  ),
                )
            )
            : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: backgroundLightColor,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: EdgeInsets.all(30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                model.bankAccount[0].bankName != null ? model.bankAccount[0].bankName : "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Image.asset("assets/images/cc_chip.png", width: 50, height: 50,),
                            SizedBox(height: 20),
                            Text(
                              model.bankAccount[0].accountNumber != null ? model.bankAccount[0].accountNumber.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ") : "",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Courier',
                                fontSize: 14
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                                model.bankAccount[0].accountName != null ? model.bankAccount[0].accountName.toUpperCase() : "".toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                fontSize: 14
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Nama Pemilik Rekening", style: TextStyle(),),
                            SizedBox(height: 10),
                            Container(
                              height: 40,
                              child: TextField(
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                decoration: InputDecoration(
                                  hintText:  model.bankAccount[0].accountName != null ? model.bankAccount[0].accountName.toUpperCase() : "",
                                  filled: true,
                                  fillColor: Colors.white,
                                   contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide: const BorderSide(color: Colors.white, width: 0.0)),
                                ),
                                style: TextStyle(
                                  backgroundColor: Colors.white,
                                  fontSize: 12
                                ),
                                enabled: false,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("Bank Rekening", style: TextStyle(),),
                            SizedBox(height: 10),
                            Container(
                              height: 40,
                              child: TextField(
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                decoration: InputDecoration(
                                  hintText:  model.bankAccount[0].bankName != null ? model.bankAccount[0].bankName : "",
                                  filled: true,
                                  fillColor: Colors.white,
                                   contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide: const BorderSide(color: Colors.white, width: 0.0)),
                                ),
                                style: TextStyle(
                                  backgroundColor: Colors.white,
                                  fontSize: 12
                                ),
                                enabled: false,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("Nomor Rekening", style: TextStyle(),),
                            SizedBox(height: 10),
                            Container(
                              height: 40,
                              child: TextField(
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                decoration: InputDecoration(
                                  hintText:  model.bankAccount[0].accountNumber != null ? model.bankAccount[0].accountNumber.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ") : "",
                                  filled: true,
                                  fillColor: Colors.white,
                                   contentPadding: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0),borderSide: const BorderSide(color: Colors.white, width: 0.0)),
                                ),
                                style: TextStyle(
                                  backgroundColor: Colors.white,
                                  fontSize: 12
                                ),
                                enabled: false,
                              ),
                            ),
                            SizedBox(height: 30),
                            RaisedGradientButton(
                                child: Text(
                                  'EDIT',
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                gradient: LinearGradient(
                                  colors: <Color>[backgroundLightColor, backgroundLightColor2],
                                ),
                                onPressed: () async {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditBankView(accountName: model.bankAccount[0].accountName, bankId: model.bankAccount[0].bankId, accountNumber: model.bankAccount[0].accountNumber),
                                      )
                                  );
                                }
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      )
                    )
                  ],
                ),
              ),
            )
          ),
        )
    );
  }
}