import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:soul_sync_app/Screens/LoginScreen/components/otp_screen.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import '../../utils/constants/color.dart';
import 'dart:io';

class ProfileForm extends StatefulWidget {
  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;

  ProfileForm({Key? key, 
  required this.firstName,
  required this.lastName,
  required this.email,
  required this.password,
  required this.confirmPassword
  }) : super(key: key);


  

  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  String? selectedGender;
  List<String> genderOptions = ["Female", "Male", "Other"];
  //List<Widget> selectedGenderChips = [];

  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController contactNumberController =
      TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController instagramUsernameController =
      TextEditingController();
  final TextEditingController graduationYearController =
      TextEditingController();

  File? image1;

  bool isLoading = false;

  // void updateSelectedGenderChips() {
  // selectedGenderChips = genderOptions.map((gender) {
  //   return FilterChip(
  //     label: Text(gender),
  //     selected: selectedGender == gender,
  //     onSelected: (selected) {
  //       setState(() {
  //         if (selected) {
  //           selectedGender = gender;
  //         } else {
  //           selectedGender = null;
  //         }
  //         updateSelectedGenderChips();
  //       });
  //     },
  //   );
  // }).toList();
//}



  Future<void> _getImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        image1 = File(pickedImage.path);
        print(image1!.path);
      });
    }
  }

  Future<void> signUpWithProfile() async {
    setState(() {
      isLoading = true;
    });

    if (!_isProfileValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("All fields are required")),
      );
      setState(() {
        isLoading = false;
      });
      return;
    }

    

    final url = 'http://localhost:4000/api/v1/auth/sendotp';
    
    try {
      final request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'firstName': widget.firstName,
      'lastName': widget.lastName,
      'email': widget.email,
      'password': widget.password,
      'confirmPassword': widget.confirmPassword,
      'dateOfBirth': dateOfBirthController.text,
      'about': aboutController.text,
      'contactNumber': contactNumberController.text,
      'height': heightController.text,
      'gender': selectedGender ?? "",
      'instagramUsername': instagramUsernameController.text,
      'graduationYear': graduationYearController.text,
    });
  
      if (image1 != null) {
      final imageFile = await http.MultipartFile.fromPath('image', image1!.path);
      request.files.add(imageFile);
    }
      final response = await request.send();
      if (response.statusCode == 200) {
        print(selectedGender);
        Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OTPScreen(
          emailController: widget.email,
          passwordController: widget.password,
          confirmController: widget.confirmPassword,
          firstNameController: widget.firstName,
          lastNameController: widget.lastName,
          dateOfBirthController: dateOfBirthController.text,
          aboutController: aboutController.text,
          contactNumberController: contactNumberController.text,
          heightController: heightController.text,
          instagramUsernameController: instagramUsernameController.text,
          graduationYearController: graduationYearController.text,
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
    return dateOfBirthController.text.isNotEmpty &&
        aboutController.text.isNotEmpty &&
        contactNumberController.text.isNotEmpty &&
        heightController.text.isNotEmpty &&
        instagramUsernameController.text.isNotEmpty &&
        graduationYearController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    //updateSelectedGenderChips();
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: dateOfBirthController,
              decoration: InputDecoration(labelText: 'Date of Birth'),
            ),
            TextField(
              controller: aboutController,
              decoration: InputDecoration(labelText: 'About'),
            ),
            TextField(
              controller: contactNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Contact Number'),
            ),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Height'),
            ),
            TextField(
              controller: instagramUsernameController,
              decoration: InputDecoration(labelText: 'Instagram Username'),
            ),
            TextField(
              controller: graduationYearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Graduation Year'),
            ),
            DropdownButton<String>(
              value: selectedGender,
              hint: Text('Select Gender'),
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                  print(selectedGender);
                });
              },
              items: genderOptions.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                },
              ).toList(),
            ),

            ElevatedButton(
              onPressed: () {
                _getImage(ImageSource.gallery); // Choose the image source
              },
              child: Text('Select Image'),
            ),
            // Display the selected image
            if (image1 != null) Container(
              height: 300,
              width: 300,
              child: Image.file(File(image1!.path))),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : signUpWithProfile,
              child: isLoading
                  ? CircularProgressIndicator(color: kSecondaryColor)
                  : Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
