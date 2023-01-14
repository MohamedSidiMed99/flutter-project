import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project2/controller/authcontroller.dart';

import 'package:project2/view/auth/signup.dart';
import 'package:project2/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';




class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  GlobalKey<FormState> formstate = GlobalKey<FormState>();

   AuthController authController = AuthController();


   bool loading = false;
   bool pageLoading = false;


  
  var data;
  Login()async{

    var formData = formstate.currentState;

    if(formData!.validate()){

      setState(() {
        loading = true;
      });

      var data =  await authController.LoginAuth(email.text, pass.text);


      if(data["result"] == "not here"){

        await Future.delayed(Duration(seconds: 3));

        setState(() {
          loading = false;
        });
        print("login");

        showDialog(
            context: context,
            builder: (context)=>AlertDialog(
              content: Text("This email is not on our data"),
            ));
      }else{


        final prefs = await SharedPreferences.getInstance();
        prefs.setString('userid', data["result"][0]['userid']);
        prefs.setString('email', data["result"][0]['email']);
        prefs.setString('username', data["result"][0]['username']);
        prefs.setString('login', 'login');


        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));

      }
    }else{


    }


  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckLogin();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      body: pageLoading ? Center(child: CircularProgressIndicator(),) : Center(
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
                      Text('Login',
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
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: (){

                          Login();

                        },
                        child: loading == false ? Text("Login",
                          style: TextStyle(
                              fontSize: 25
                          ),):
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(color: Colors.white,)),
                                SizedBox(width: 10,),
                                Text("Loading...",
                                  style: TextStyle(
                                      fontSize: 20
                                  ),)
                              ],
                            )

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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                        },
                        child: Text("Register->",
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
      )
    );
  }



  CheckLogin()async{
    setState(() {
      pageLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    var login = prefs.get('login');

    if(login == "login"){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
    }else{

      setState(() {
        pageLoading =false;
      });
    }
  }

}
