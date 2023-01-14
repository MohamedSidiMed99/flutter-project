
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constant/links.dart';
class GetPostsController{


  Future getPosts(userid)async{

    var url = GETPOSTS;
    var res = await http.post(Uri.parse(url),body: {
      "userid":userid
    });

    if(res.statusCode == 200){
      var data = jsonDecode(res.body);

      print(data);
      return data;
    }
  }
}