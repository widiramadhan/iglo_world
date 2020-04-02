import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/utility/app_utility.dart';
import 'package:iglo_world/core/viewmodels/issue_closed_viewmodel.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/empty_view.dart';
import 'package:iglo_world/ui/views/issue_detail_view.dart';
import 'package:iglo_world/ui/widgets/skeleton.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class IssueClosedView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BaseView<IssueClosedViewModel>(
        onModelReady: (model) => model.getIssueClosed(),
        builder: (context, model, child) =>
        model.issueClosed == null ? Center( child: IssueSkeleton()) : ModalProgressHUD(
              inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "Total Closed Response",
                          style: TextStyle(
                          ),
                        ),
                        SizedBox(width: 10,),
                        Badge(
                          padding: EdgeInsets.all(8),
                          badgeContent: Text(model.issueClosed.length.toString(), style: TextStyle(color: Colors.red,)),
                          badgeColor: Colors.white,
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    model.issueClosed.isEmpty ? EmptyDataView() : ListView.builder(
                        shrinkWrap: true,
                        itemCount: model.issueClosed.length,
                        controller: ScrollController(keepScrollOffset: false),
                        itemBuilder: (BuildContext context, int index) => Container(
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => IssueDetailView(issueId: model.issueClosed[index].issueId, issueType: "closed",),
                                  )
                              );
                            },
                            child: Card(
                              margin: EdgeInsets.only(top: 7, bottom: 7),
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
                                        children: <Widget>[
                                          /*Container(
                                            child: Text(
                                              "Issue",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),*/
                                          Container(
                                            margin: EdgeInsets.only(top:8),
                                            child: Text(
                                              "Subject",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top:8),
                                            child: Text(
                                              "Description",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top:8),
                                            child: Text(
                                              "Create Date",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          /*Container(
                                            child: Text(
                                              model.issueClosed[index].issueName,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),*/
                                          Container(
                                            margin: EdgeInsets.only(top:8),
                                            child: Text(
                                              model.issueClosed[index].subject,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top:8),
                                            child: Text(
                                              model.issueClosed[index].description,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top:8),
                                            child: Text(
                                              model.issueClosed[index].dateString,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                    )
                  ],
                ),
              ),
            )
    );
  }
}