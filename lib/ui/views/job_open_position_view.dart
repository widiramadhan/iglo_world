import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/models/job_category.dart';
import 'package:iglo_world/core/utility/app_utility.dart';
import 'package:iglo_world/core/viewmodels/job_position_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/empty_view.dart';
import 'package:iglo_world/ui/views/job_position_detail_view.dart';
import 'package:iglo_world/ui/widgets/skeleton.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class JobOpenPositionView extends StatefulWidget {
  @override
  _JobOpenPositionViewState createState() => _JobOpenPositionViewState();
}

class _JobOpenPositionViewState extends State<JobOpenPositionView> {

  String tag = "0";

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<JobPositionViewModel>(
      onModelReady: (model) => model.getAll(tag.toString()),
        builder: (context, model, child) =>
        model.jobPosition == null || model.jobCategory == null ? Center( child: JobPositionSkeleton()) :
        ModalProgressHUD(
            inAsyncCall: model.state == ViewState.Busy ?? ViewState.Idle,
            //child: model?.jobPosition?.isEmpty ?? true ? EmptyDataView() : Container(
            child: Container(
              child: Column(
                children: <Widget>[
                  ChipsChoice<String>.single(
                    value: tag,
                    options: ChipsChoiceOption.listFrom<String, JobCategory>(
                        source: model.jobCategory,
                        value: (i, v) => v.jobCategoryId,
                      label: (i, v) => v.jobCategoryName,
                    )..insert(0, ChipsChoiceOption<String>(value: '0', label: 'All')),
                    onChanged: (val) {
                      setState(() => tag = val);
                      model.getJobPosition(val.toString());
                    },
                    isWrapped: true,
                  ),
                  model.jobPosition.isEmpty ? EmptyDataView() : Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                "Total Open Position",
                                style: TextStyle(),
                              ),
                              SizedBox(width: 10,),
                              Badge(
                                padding: EdgeInsets.all(8),
                                badgeContent: Text(model.jobPosition.length.toString(), style: TextStyle(color: Colors.red, fontSize: 10)),
                                badgeColor: Colors.white,
                              )
                            ],
                          ),
                          SizedBox(height: 10,),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.jobPosition.length,
                            controller: ScrollController(keepScrollOffset: false),
                            itemBuilder: (BuildContext context, int index) => Container(
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => JobPositionDetailView(job_id: model.jobPosition[index].jobId),
                                      )
                                  );
                                },
                                child: Card(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                model.jobPosition[index].jobName,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: backgroundLightColor
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    "Start from : ",
                                                    style: TextStyle(
                                                        fontSize: 10
                                                    ),
                                                  ),
                                                  Text(
                                                    "Rp. "+model.jobPosition[index].offeredSalary,
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 10
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  )
                                                ],
                                              ),
                                              SizedBox(height: 10,),
                                              Row(
                                                children: <Widget>[
                                                  Icon(Icons.calendar_today, size: 8, color: Colors.blue,),
                                                  SizedBox(width: 10,),
                                                  Text(
                                                    model.jobPosition[index].experience,
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 8
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]
                    ),
                  ),
                ],
              ),
            ),
        ),
    );
  }
}
