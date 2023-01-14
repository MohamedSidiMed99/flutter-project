

import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../constant/links.dart';

class AddLikeController{

  final userid;
  final postid;
  AddLikeController({
    this.userid,
    this.postid
});

  Future setLike()async{
    var url = ADDLIKE;
    var res = await http.post(Uri.parse(url),body: {
      "userid":userid,
      "postid":postid
    });

    if(res.statusCode == 200){
      var data = jsonDecode(res.body);

      print(data);
    }

  }
}