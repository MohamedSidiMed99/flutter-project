import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constant/links.dart';



class GetUsersController {


  Future getData()async{
    var url = URL;
    var res = await http.get(Uri.parse(url));

    if(res.statusCode == 200){
      var data = jsonDecode(res.body);

      return data;
    }
  }
}