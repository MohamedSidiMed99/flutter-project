
import 'package:http/http.dart' as http;
import '../../constant/links.dart';

class AddPostsController{

  final userid;
  final img;

  AddPostsController({
    this.userid,
    this.img
});

  Future addPost()async{
    var url = ADDPOST;
    var req = http.MultipartRequest("POST",Uri.parse(url));
    req.fields['userid'] = userid;
    var pic = await http.MultipartFile.fromPath("img",img);
    req.files.add(pic);

    var res = req.send();
    print("done");
  }
}