import 'package:flutter/material.dart';
import 'package:project2/controller/authcontroller.dart';

import 'login.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  AuthController authController = AuthController();
  bool loading = false;

 SignUp()async{

    var formData = formstate.currentState;

    if(formData!.validate()){
      setState(() {
        loading = true;
      });
    var data =  await authController.SignUpAuth(name.text, email.text, pass.text);

      if(data['result'] == "done"){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
      }else{
        print("not here");
        Future.delayed(Duration(seconds: 3),()=>{
          setState(() {
            loading = false;
          }),
          print("not here"),
          showDialog(
              context: context,
              builder: (context)=>AlertDialog(
                  content: Text("This email is already on the database")
              )

          ),
        });
      }
    }else{


    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formstate,
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Sign Up',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.lightBlue
                        ),),
                    ],
                  ),
                ),

                ///-----------------Eneter Emeil -----------------


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: name,
                    validator: (val){
                      if(val!.isEmpty){
                        return "input is empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "username",

                      prefixIcon: Icon(Icons.person),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),

                      focusedBorder:
                      OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),

                ///-----------------Eneter Emeil -----------------


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: email,
                    validator: (val){
                      if(val!.isEmpty){
                        return "input is empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Email",

                      prefixIcon: Icon(Icons.email),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),

                      focusedBorder:
                      OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                ///-----------------Eneter password -----------------

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(

                    controller: pass,
                    validator: (val){
                      if(val!.isEmpty){
                        return "input is empty";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "password",

                      prefixIcon: Icon(Icons.password),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),

                      focusedBorder:
                      OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),


                Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){

                          SignUp();

                        },
                        child:loading == false? Text("Sign Up",
                          style: TextStyle(
                              fontSize: 25
                          ),):
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(color: Colors.white,)),
                            ),
                            SizedBox(width: 5,),
                            Text("Loading...",
                              style: TextStyle(
                                  fontSize: 20
                              ),)
                          ],
                        ),
                      ),
                    )

                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap:(){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                        },
                        child: Text("Login->",
                          style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 17
                          ),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
