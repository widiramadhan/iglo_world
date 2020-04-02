
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewerView extends StatelessWidget {
  String path;

  PhotoViewerView({Key key, this.path});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, allowFontScaling: true);
    return Scaffold(
          appBar: AppBar(
            title:Text("Photo Viewer", style: TextStyle(fontSize: ScreenUtil().setWidth(40))),
            leading: IconButton( icon: new Icon(Icons.arrow_back, size: ScreenUtil().setWidth(50),),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Container(
          child: PhotoView(
            imageProvider: NetworkImage(path),
          )
      )
    );
  }
}
