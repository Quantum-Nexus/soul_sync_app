import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soul_sync_app/Screens/Home/home.dart';
import 'package:soul_sync_app/Screens/LoginScreen/login_screen.dart';
import 'package:soul_sync_app/utils/constants/color.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class OTPScreen extends StatefulWidget {

  final String emailController; 
  final String passwordController;
  final String confirmController;
  final String firstNameController;
  final String lastNameController;
  final String dateOfBirthController;
  final String aboutController; 
  final String contactNumberController; 
  final String heightController;
  final String instagramUsernameController;
  final String graduationYearController;
  final String? selectedGender;

  late File? image;

    OTPScreen({Key? key, 
  required this.emailController, 
  required this.passwordController, 
  required this.confirmController, 
  required this.firstNameController, 
  required this.lastNameController, 
  required this.dateOfBirthController, 
  required this.aboutController, 
  required this.contactNumberController, 
  required this.heightController, 
  required this.instagramUsernameController, 
  required this.graduationYearController,
  required this.image, 
  required this.selectedGender,  }) : super(key: key);
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;
  
  final _picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery );

    if (pickedImage != null) {
      setState(() {
        widget.image = File(pickedImage.path);
        print(widget.image !.path);
      });
    }
  }


  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(6, (index) => FocusNode());
    _controllers = List.generate(6, (index) => TextEditingController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP sent successfully'),
          //duration: Duration(seconds: 5),
        ),
      );
    });
  }

  void onDigitEntered(int index, String value) {
    if (value.length > 1) {
      value = value.substring(0, 1); // Only take the first character
    }

    _controllers[index].text = value;

    if (value.isNotEmpty && index < _focusNodes.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
  }

  String otp = '';
  void verifyOTP() async{
  
  for (var controller in _controllers) {
    otp += controller.text;
  }  


  // for (var controller in _controllers) {
  //   controller.clear();

  // }
  


    const url ='http://localhost:4000/api/v1/auth/signup'; // Replace with your actual API endpoint

  final request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'email': widget.emailController,
      'password': widget.passwordController,
      'confirmPassword': widget.confirmController,
      'firstName': widget.firstNameController,
      'lastName': widget.lastNameController,
      'dateOfBirth': widget.dateOfBirthController,
      'about': widget.aboutController,
      'contactNumber': widget.contactNumberController,
      'height': widget.heightController,
      'instagramUsername': widget.instagramUsernameController,
      'graduationYear': widget.graduationYearController,
      'gender': widget.selectedGender ?? "",
      'otp': otp
    });
    

  //print(response);

  // Navigator.pop(context); // Close loading dialog
      if (widget.image != null) {
        var stream = new http.ByteStream(widget.image!.openRead());
      stream.cast();

      var length = await widget.image!.length();
      final imageFile = await http.MultipartFile('image',stream,length);
      request.files.add(imageFile);

      
    }
      var response = await request.send(); 
  if (response.statusCode == 200) {
  ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 5),
        content: Text('Account created successfully'),
        //duration: Duration(seconds: 2), // Optional: Specify duration for the Snackbar
      ),
    );

    // Navigate to the LoginScreen
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ));

  } else{
    final responseBody = await response.stream.bytesToString();
    if (responseBody.contains('message')) {
        final errorMessage = json.decode(responseBody)['message'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
    }
  
  print('Entered OTP: $otp'); 
  otp ='';// Print the OTP as a string
  // Now you can use the 'otp' variable as needed (e.g., send it to the server for verification).
}
  }


  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter the OTP sent to your email',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < _controllers.length; i++)
                  buildDigitInput(i),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap:() {verifyOTP();},
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2.0, color: kPrimaryLightColor),
                      ),
                  child: const Text(
                    'Verify OTP',
                    style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }



Widget buildDigitInput(int index) {
    return Container(
      width: 50,
      height: 55,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: _focusNodes[index].hasFocus ? const Color.fromARGB(255, 117, 194, 233): kSecondaryLightColor,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        onChanged: (value) => onDigitEntered(index, value),
        decoration: const InputDecoration(
          counterText: '', // Hide the character count
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 117, 194, 233),width: 2.0) ),
          disabledBorder: InputBorder.none
        ),
      ),
    );
  }
}





