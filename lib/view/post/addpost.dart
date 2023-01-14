import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project2/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/posts/addpostscontroller.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  XFile? img;
  ImagePicker picimg = ImagePicker();

  GetImg()async{
    var pic = await picimg.pickImage(source: ImageSource.gallery);
    setState(() {
      img = XFile(pic!.path);
    });

    UploadImg();
  }

  UploadImg()async{
   await AddPostsController(
     userid: userid,
     img: img!.path
   ).addPost();

   await Future.delayed(Duration(seconds: 2));
   Navigator.push(context, MaterialPageRoute(builder: (builder)=>Home()));
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }

  getData()async{
    await getShared();

  }
  var username;
  var email;
  var userid;

  getShared()async{
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userid = prefs.get('userid');
      username = prefs.get('username');
      email = prefs.get('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: (){
                  GetImg();
                },
                icon: Icon(Icons.photo,size: 60,))
          ],
        ),
      ),
    );
  }
}
