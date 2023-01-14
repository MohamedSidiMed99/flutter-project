import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project2/view/auth/login.dart';
import 'package:project2/view/post/addpost.dart';
import 'package:project2/view/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/links.dart';
import '../controller/controller.dart';


import 'favorite.dart';
import 'homepage.dart';


class Home extends StatefulWidget {
  final username;
  final email;

  const Home({this.username,this.email});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GetUsersController getdata =   GetUsersController();

  //  XFile? img;
  // ImagePicker imgpic = ImagePicker();
  //
  // getImage()async{
  //   final pic = await imgpic.pickImage(source: ImageSource.gallery);
  //
  //   setState(() {
  //     img = XFile(pic!.path);
  //   });
  //   print(img!.path);
  //
  //   showDialog(
  //       context: context,
  //       builder: (builder)=>AlertDialog(
  //         content: Row(
  //           children: [
  //             ElevatedButton(
  //                 onPressed: (){
  //                   print("upload now");
  //                   uploadImg();
  //                 },
  //                 child: Text("Upload img"))
  //           ],
  //         ),
  //       ));
  // }
  //
  // Future uploadImg()async{
  //   var url = "http://192.168.0.102:9000/upload";
  //   var req = await http.MultipartRequest("post",Uri.parse(url),);
  //   req.fields['name']="moftah";
  //   var pic =await http.MultipartFile.fromPath("img", img!.path);
  //   req.headers.addAll({
  //     "Content-Type":"multipart/form-data",
  //     // "Authorization":"Barear"
  //   });
  //   req.files.add(pic);
  //
  //   var res = await req.send();
  //
  //   if(res.statusCode == 200){
  //     print("done");
  //   }
  // }




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

  int current = 1;

  @override
  Widget build(BuildContext context) {

    List Pages = [
      Profile(),
      HomePage(),
      Favorite()
    ];

    return Scaffold(

      appBar: AppBar(

        title: Text("Post app"),

      ),

      drawer: Drawer(

        child: Column(
          children: [

            Stack(
              children: [

                Container(
                  height: 200,
                  width: double.infinity,
                  child: Image.asset("images/2.jpg",fit: BoxFit.cover,),
                ),

                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                ),
                
                Container(
                  height: 200,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child:CircleAvatar(
                    radius: 62,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 60,
                      foregroundImage: AssetImage("images/1.jpg"),
                    ),
                  ),
                ),


              ],
            ),

            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
              },
              leading:Icon(Icons.home),
              title: Text("Home"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
            ListTile(
              onTap: ()async{
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));

                final prefs = await SharedPreferences.getInstance();
                prefs.clear();

              },
              leading:Icon(Icons.logout),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward_ios),
            )
          ],
        ),
      ),

      body:  Pages[current],


      bottomNavigationBar: BottomNavigationBar(

        fixedColor: Colors.red,
        currentIndex: current,
        onTap: (val){
          setState(() {
            current = val;
          });
        },

        items: [

          BottomNavigationBarItem(
              icon: Icon(Icons.person),
            label: "Profile"
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home"
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: "Favorite"
          ),
        ],
      ),



      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (builder)=>AddPost()));
        },
        child: Icon(Icons.add),
      ),


    );
  }
}
