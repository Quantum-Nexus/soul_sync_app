import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:soul_sync_app/utils/constants/color.dart';

import '../../LoginScreen/components/otp_screen.dart';

class AboutMe extends StatefulWidget {
  int age;
  String gender;
  int height;
  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;
  int number;

  AboutMe({super.key, 
  required this.age, 
  required this.height,
  required this.gender,
  required this.firstName,
  required this.lastName,
  required this.email,
  required this.password,
  required this.confirmPassword,
  required this.number
  });

  @override
  State<AboutMe> createState() => _AboutMeState();
}

class _AboutMeState extends State<AboutMe> {
  final _formKey = GlobalKey<FormState>();
  String _instagramId = '';
  String _about = '';
  bool isPressed = false;
  File? _pickedImage; // To store the picked image
  bool isLoading = false;

  Future<void> _showImageSourceDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: kPrimaryLightColor,
          title: Text("Select Image Source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text("Camera"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                SizedBox(height: 20),
                GestureDetector(
                  child: Text("Gallery"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImageFile = await ImagePicker().pickImage(
      source: source,
      maxWidth: 600,
    );

    if (pickedImageFile != null) {
      setState(() {
        _pickedImage = File(pickedImageFile.path);
      });
    }
  }
  void _toggledataButtonState() {
    setState(() {
      if (_pickedImage != null && _instagramId != "" && _about != "") {
        isPressed = !isPressed;
      } else {
        if (_pickedImage == "" && (_instagramId != 0 && _about != "")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please pick an image."),
              backgroundColor: kPinkColor,
            ),
          );
        } else if (_instagramId == "" && (_pickedImage != null && _about != "")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please enter your instagram id."),
              backgroundColor: kPinkColor,
            ),
          );
        } else if (_about == "" && ( _pickedImage != null && _about != "")){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please enter your about."),
              backgroundColor: kPinkColor,
            ),
          );
        }
        else if(_instagramId != "" && (_pickedImage == null && _about == "")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please select an image and enter your about."),
              backgroundColor: kPinkColor,
            ),
          );
        }
        else if(_about != "" && ( _pickedImage == null && _instagramId == "")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please select an image and enter your instagram id."),
              backgroundColor: kPinkColor,
            ),
          );
        }
        else if(_pickedImage != "" && (_instagramId == 0 && _about == "")) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please enter your instagram id and about."),
              backgroundColor: kPinkColor,
            ),
          );
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Please enter valid input fields."),
              backgroundColor: kPinkColor,
            ),
          );

        }
      }
    });
    print(_pickedImage);
    print(_instagramId);
    print(_about);
  }

  Future<void> signUpWithProfile() async {
    setState(() {
      isLoading = true;
    });

    // if (!_isProfileValid()) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text("All fields are required")),
    //   );
    //   setState(() {
    //     isLoading = false;
    //   });
    //   return;
    // }

    
    
    final url = 'http://localhost:4000/api/v1/auth/sendotp';
    
    try {

      final request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'email': widget.email,
    });
  
    //   if (image != null) {
    //     var stream = new http.ByteStream(image!.openRead());
    //   stream.cast();

    //   var length = await image!.length();
    //   final imageFile = await http.MultipartFile('image',stream,length);
    //   request.files.add(imageFile);

    //   var response = await request.send(); 
    // }
      final response = await request.send();
      if (response.statusCode == 200) {
        
        Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OTPScreen(
          emailController: widget.email,
          passwordController: widget.password,
          confirmController: widget.confirmPassword,
          firstNameController: widget.firstName,
          lastNameController: widget.lastName,
          dateOfBirthController: widget.age.toString(),
          aboutController: _about,
          contactNumberController: widget.number.toString(),
          heightController: widget.height.toString(),
          instagramUsernameController: _instagramId,
          graduationYearController: '',
          image: _pickedImage,
          selectedGender: widget.gender,
          )
    ));
        // Successfully signed up
        // TODO: Navigate to OTPScreen or any other screen as needed
      } else {
        final responseBody = await response.stream.bytesToString();

        if (responseBody.contains('message')) {
        final errorMessage = json.decode(responseBody)['message'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage)),
        );
      }
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred. Please try again later.')),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  bool _isProfileValid() {
    return _instagramId.isNotEmpty &&
        _about.isNotEmpty &&
        _pickedImage != null;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      resizeToAvoidBottomInset:
          false, // Add this line to prevent automatic scrolling

      body: Container(
        height: height,
        width: width,
        margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              color: kPinkColor,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios_new),
            ),
            Row(
              children: [
                Text(
                  "3 ",
                  style: GoogleFonts.barlow(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                    ),
                ),
                Text(" OF ", 
                style: GoogleFonts.barlow(
                    color: Colors.white54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                    ),
                ),
                Text("3", 
                style: GoogleFonts.barlow(
                    color: Colors.white54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                    ),
                )
              ],
            ),
            SizedBox()
          ],
        ),
            Container(
              // height: height *0.065,
              //margin: EdgeInsets.only(top: height * 0.065),
              child: Text.rich(
                TextSpan(
                    text: 'Love at first ',
                    style: kDHead2Style,
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'Pic',
                        style: GoogleFonts.urbanist(
                          fontSize: height * 0.045,
                          fontWeight: FontWeight.bold,
                          color: kPinkColor,
                        ),
                      ),
                    ]),
              ),
            ),
            Form(
              key: _formKey,
              child: Container(
                height: height * 0.38,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ImageInputContainer(
                        image: _pickedImage,
                        onTap: () async {
                          await _showImageSourceDialog(context);
                        },
                      ),
                      TextFormField(
                        cursorColor: kPrimaryLightColor,
                        style: const TextStyle(color: kPrimaryLightColor),
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kPrimaryLightColor, width: 0.25),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Instagram ID',
                          labelStyle: TextStyle(
                              color: kPrimaryLightColor), // Hint text color
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: kPrimaryLightColor,
                                width: 0.25), // Border color
                          ),
                        ),
                        onChanged: (value) {
                          _instagramId = value;
                        },
                      ),
                      TextFormField(
                        cursorColor: kPrimaryLightColor,
                        style: const TextStyle(color: kPrimaryLightColor),
                        maxLines: 3,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: kPrimaryLightColor, width: 0.25),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'About',
                          hintText: "Once Upon a Swipe...",
                          hintStyle: TextStyle(color: Colors.white38),
                          hintMaxLines: 3,
                          labelStyle: TextStyle(
                              color: kPrimaryLightColor), // Hint text color
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                                color: kPrimaryLightColor,
                                width: 0.25), // Border color
                          ),
                        ),
                        onChanged: (value) {
                          _about = value;
                        },
                      ),
                    ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                
                _toggledataButtonState();
                if(isPressed){
                signUpWithProfile();
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: height * 0.060,
                // width: double.maxFinite,
                decoration: BoxDecoration(
                  // border: Border.all(
                  // color: Colors.red, width: 1, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(10),
                  color: kPrimaryLightColor,
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                      color: kPrimaryColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageInputContainer extends StatefulWidget {
  final File? image;
  final VoidCallback onTap;

  ImageInputContainer({required this.image, required this.onTap});

  @override
  _ImageInputContainerState createState() => _ImageInputContainerState();
}

class _ImageInputContainerState extends State<ImageInputContainer> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: width * 0.35,
        height: height * 0.16,
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kPrimaryLightColor, width: 0.25),
        ),
        child: Stack(
          children: [
            if (widget.image != null)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(widget.image!, fit: BoxFit.cover),
                ),
              ),
            Center(
              child: Icon(
                Icons.add,
                color: kPrimaryLightColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
