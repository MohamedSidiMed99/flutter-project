
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project2/constant/links.dart';
class AuthController {


  Future LoginAuth(email,pass)async{

    var url = LOGIN;
    var res = await http.post(Uri.parse(url),body: {
       "email":email,
       "pass":pass
    });


    if(res.statusCode == 200){
      var data = jsonDecode(res.body);

      return data;
    }
  }

  Future SignUpAuth(name,email,pass)async{
    var url = SIGNUP;
    var res = await http.post(Uri.parse(url),body: {
      "name":name,
      "email":email,
      "pass":pass
    },);

    if(res.statusCode == 200){
      var data = jsonDecode(res.body);

      return data;
    }

  }
}