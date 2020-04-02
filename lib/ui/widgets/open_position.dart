import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iglo_world/core/enums/viewstate.dart';
import 'package:iglo_world/core/viewmodels/home_viewmodel.dart';
import 'package:iglo_world/ui/shared/app_colors.dart';
import 'package:iglo_world/ui/views/base_view.dart';
import 'package:iglo_world/ui/views/empty_view.dart';
import 'package:iglo_world/ui/views/job_position_detail_view.dart';

class OpenPosition extends StatefulWidget {
  @override
  _OpenPositionState createState() => _OpenPositionState();
}

class _OpenPositionState extends State<OpenPosition> {

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      onModelReady: (model) => model.getJobPosition(),
      builder: (context, model, child) =>
        model.jobPosition == null ? Center( child: CircularProgressIndicator()) : Container(
        child: model.state == ViewState.Busy
            ? Center(child: CircularProgressIndicator())
            : model.jobPosition.isEmpty ? EmptyDataView() : ListView.builder(
          shrinkWrap: true,
          itemCount: model.jobPosition.length <= 5 ? model.jobPosition.length : 5,
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
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
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                Icon(Icons.calendar_today, size: 8, color: Colors.blue),
                                SizedBox(width: 5,),
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
      ),
    );
  }
}
