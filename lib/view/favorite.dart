import 'package:flutter/material.dart';


class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {

  var name ;
  getData(){

    setState(() {
      name = "Favorite";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("$name")),
          ElevatedButton(
          onPressed: (){
            setState(() {
              name = "moftah";
            });
          },
         child:Text("change") )
        ],
      ),
    );
  }
}