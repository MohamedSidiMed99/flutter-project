import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/links.dart';
import '../controller/posts/addlike.dart';
import '../controller/posts/getpostscontroller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List Posts = [

    {"id":"1","username":"mohamed","img":"images/1.jpg"},
    {"id":"2","username":"moftah","img":"images/2.jpg"},
    {"id":"3","username":"ali","img":"images/3.jpg"},
    {"id":"4","username":"mariem","img":"images/4.JPG"},
    {"id":"5","username":"sidi","img":"images/5.jpg"},
    {"id":"6","username":"lara","img":"images/6.JPG"},
    {"id":"7","username":"didi","img":"images/7.jpg"},
    {"id":"8","username":"morad","img":"images/8.jpg"},
    {"id":"9","username":"arbi","img":"images/9.jpg"},
    {"id":"10","username":"med lemin","img":"images/10.JPG"},
    {"id":"11","username":"romario","img":"images/11.JPG"},
    {"id":"12","username":"danial","img":"images/12.jpg"},

  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData()async{
    await  getShared();

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

      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [

          ///---------------- list scroll horizontal
          Container(
            width: double.infinity,
            height: 150,

            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: Posts.length,
                itemBuilder: (ctx,i){

                  return Container(
                    width: 400,
                    height: 150,
                    child: Card(
                      child: Stack(
                        children: [

                          Container(
                              width: 400,
                              height: 150,
                              child: Image.asset("${Posts[i]['img']}",fit: BoxFit.cover,)),

                          Container(
                            width: 390,
                            height: 150,
                            alignment: Alignment.center,
                            color: Colors.black.withOpacity(0.3),
                          ),

                          Container(
                              width: 390,
                              height: 150,
                              alignment: Alignment.center,
                              child: Text("${Posts[i]['username']}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold
                                ),)),

                          Container(
                            width: 390,
                            height: 150,
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 30,
                                width: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(50)
                                ),
                                child: Text("${Posts[i]['id']}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                  ),),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  );
                }),
          ),

          ///---------------- Posts -----------------


         FutureBuilder<dynamic>(
             future:GetPostsController().getPosts(userid) ,
             builder: (stx,snp){
               if(!snp.hasData){
                 return Center(child: Text("no data"),);
               }else if(snp.hasError){
                 return Center(child: CircularProgressIndicator(),);
               }else{
                 return ListView.builder(
                     shrinkWrap: true,
                     physics: BouncingScrollPhysics(),
                     itemCount: snp.data!.length,
                     itemBuilder: (ctx,i){
                       return Container(
                           decoration: BoxDecoration(

                               borderRadius: BorderRadius.circular(5)
                           ),
                           height: 300,
                           width: double.infinity,
                           child: Card(

                               child: Stack(
                                 children: [

                                   ClipRRect(
                                     borderRadius: BorderRadius.circular(5),
                                     child: Container(
                                       height: 300,
                                       width: double.infinity,
                                       child: Image.network(IMG  + snp.data[i]['img'],fit: BoxFit.cover,),
                                     ),
                                   ),

                                   Container(
                                     decoration: BoxDecoration(
                                         color: Colors.black.withOpacity(0.3),
                                         borderRadius: BorderRadius.circular(5)
                                     ),
                                     height: 300,
                                     width: double.infinity,


                                   ),


                                   Container(

                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Row(
                                         crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           CircleAvatar(
                                             radius: 22,
                                             backgroundColor: Colors.white,
                                             child: CircleAvatar(

                                               radius: 20,
                                               foregroundImage: AssetImage("${Posts[i]['img']}"),
                                             ),
                                           ),

                                           SizedBox(width: 10,),
                                           Text("${Posts[i]['username']}",
                                             style: TextStyle(
                                                 color: Colors.white,
                                                 fontSize: 18
                                             ),),
                                         ],
                                       ),
                                     ),
                                   ),

                                   Container(
                                     height: 300,
                                     width: double.infinity,
                                     alignment: Alignment.bottomCenter,
                                     child: Container(
                                       height: 50,
                                       width: double.infinity,
                                       color: Colors.black.withOpacity(0.5),
                                       child: Row(

                                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                                         children: [



                                           Row(
                                             children: [
                                               setLike(snp.data[i]['id'],snp.data[i]['like']),
                                               Text("${snp.data[i]['likesnumber'] ?? '0'}",
                                               style: TextStyle(
                                                 color: Colors.white
                                               ),)
                                             ],
                                           ),
                                           
                                           Icon(Icons.comment ,color: Colors.white,size: 30,),
                                           Icon(Icons.share ,color: Colors.white,size: 30,),
                                         ],
                                       ),
                                     ),
                                   ),

                                 ],
                               )));
                     });
               }
             }),


        ],
      ),
    );
  }

  Widget setLike(postid,liked){
     if(liked == "true"){
       return  IconButton(
           onPressed: ()async{
             await AddLikeController(
                 userid: userid,
                 postid: postid
             ).setLike();

             setState(() {

             });
           },
           icon: Icon(Icons.favorite, color: Colors.red, size: 30,)
       );
     }else{
       return  IconButton(
           onPressed: ()async{
             await AddLikeController(
                 userid: userid,
                 postid: postid
             ).setLike();
             setState(() {

             });
           },
           icon: Icon(Icons.favorite, color: Colors.white, size: 30,)
       );
     }
  }

}
