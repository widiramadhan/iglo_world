import 'dart:convert';
import 'dart:io';
import 'package:convert/convert.dart';

import 'package:crypto/crypto.dart' as crypto;
import 'package:date_format/date_format.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path;

class AppUtility {

  static const fontSize = 12.0;
  static const layoutPadding = 20.0;
  static const textFieldHeight = 40.0;
  static const textFieldPadding = 10.0;


   static generateMd5(String data) {
     var content = new Utf8Encoder().convert(data);
     var md5 = crypto.md5;
     var digest = md5.convert(content);
     return hex.encode(digest.bytes);
   }

   static dateFormated(String date){
     return formatDate(DateTime.parse(date), [d, ' ', MM, ' ', yyyy]);
   }

   static Future<void> openMap(double latitude, double longitude) async {
     String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
     if (await canLaunch(googleUrl)) {
       await launch(googleUrl);
     } else {
       throw 'Could not open the map.';
     }
   }

   static getCurrentLocation() async {
     Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
     return position;
   }

   static Future<String> getFileNameWithExtension(File file)async{
     if(await file.exists()){
       return path.basename(file.path);
     }else{
       return null;
     }
   }


 }