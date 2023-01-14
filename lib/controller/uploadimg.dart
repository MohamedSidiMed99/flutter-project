import 'package:http/http.dart' as http;

import '../constant/links.dart';

class UploadImgController{


  Future Uploadimg(img)async{

    var url = "";
    var req = http.MultipartRequest("POST",Uri.parse(url),);
    req.fields['username'] = "moftah";
    var pic = await http.MultipartFile.fromPath("img", img);

    req.files.add(pic);

    var res = await req.send();

    if(res.statusCode == 200) {
      print("done");
    }
  }
}