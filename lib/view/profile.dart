
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project2/controller/uploadimg.dart';



class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  var name ;
  getData(){

    setState(() {
      name = "Profile";
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }


  XFile? img;
  ImagePicker picimg = ImagePicker();

  getImage()async{
    var pic = await picimg.pickImage(source: ImageSource.gallery);

    setState(() {
      img = XFile(pic!.path);
    });

    ShowDialog();
  }

  ShowDialog(){

    showDialog(
        context: context,
        builder: (builder)=>AlertDialog(
          content: Row(
            children: [
              ElevatedButton(
                onPressed: (){
                  Upload();
                },
                child: Text("upload"),
              ),

              ElevatedButton(
                onPressed: (){

                  Navigator.pop(context);
                },
                child: Text("cancel"),
              ),
            ],
          ),
        ));
  }

  Upload()async {
     await UploadImgController().Uploadimg(img!.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Center(child: Text("Profile"),
     ),
    );
  }
}
