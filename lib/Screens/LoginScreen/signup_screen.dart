
import 'package:flutter/material.dart';

import '../../utils/constants/color.dart';
import 'components/inputField.dart';


//import '../auth/auth_service.dart'



class SignupScreen extends StatefulWidget {
  final void Function()? onTap;

  const SignupScreen({Key? key,  this.onTap}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final usernameController = TextEditingController();

  void signUp() async {
    if(passwordController.text != confirmController.text){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Passwords donot match!")
          )
      );
      return;
    }
    showDialog(context: context, builder: (context){
      return Center(
        child: CircularProgressIndicator(color: kSecondaryColor,),
      );
    });

    try {
      // await FirebaseAuth.instance.createUserWithEmailAndPassword(
      //     email: emailController.text,
      //     password: passwordController.text);

      Navigator.pop(context);
    } catch (e){
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
      );
    }
  }



  bool passwordVisible=false;

  @override
  void initState(){
    super.initState();
    passwordVisible=true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(70.0),
                child: Text(
                  'Soul Sync',
                  style: kLogoStyle,
                ),
              ),
              const Center(
                  child: Text(
                    'Signup',
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Rubik Medium',
                        color: kSecondaryLightColor),
                  )),
              const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Text(
                      'Create your Account',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Rubik Regular',
                          color: kTextColor),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 20),
                // child:
              ),
              InputField(
                passwordcontroller: passwordController,
                emailcontroller: emailController),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: TextFormField(
                  obscureText: passwordVisible,
                  controller: confirmController ,
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    fillColor: kSecondaryLightColor,

                    filled: true,
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: kSecondaryColor,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility),color: kSecondaryColor,
                      onPressed: () {
                        setState(
                              () {
                            passwordVisible = !passwordVisible;
                          },
                        );
                      },
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffE4E7EB),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffE4E7EB),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            
              const SizedBox(
                height: 100,
              ),
              GestureDetector(
                onTap: (){
                  signUp();

                },
                child: Container(
                  width: 300,
                  height: 50,
                  decoration: BoxDecoration(
                    color: kSecondaryLightColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Signup',
                      style: TextStyle(
                        fontFamily: 'Rubik Regular',
                        fontSize: 20,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Text(
                      'Already a member?',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Rubik Regular',
                          color: kSecondaryLightColor),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        ' Login',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Rubik Medium',
                            color: Colors.white),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

