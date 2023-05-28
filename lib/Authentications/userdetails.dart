import 'dart:io';

import 'package:clouds/Authentications/user_model.dart';
import 'package:clouds/Screens/CommonScreens/custom_button.dart';
import 'package:clouds/Screens/CommonScreens/navigation_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'provider/authentication_provider.dart';
import 'snackbar.dart';

class UserInfromationScreen extends StatefulWidget {
  const UserInfromationScreen({super.key});

  @override
  State<UserInfromationScreen> createState() => _UserInfromationScreenState();
}

class _UserInfromationScreenState extends State<UserInfromationScreen> {
  File? image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
  }

  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading == true
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 0, 139, 32),
                ),
              )
            : SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
                child: Center(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () => selectImage(),
                        child: image == null
                            ? const CircleAvatar(
                                backgroundColor:
                                    Color.fromARGB(255, 0, 139, 32),
                                radius: 50,
                                child: Icon(
                                  Icons.account_circle,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(image!),
                                radius: 50,
                              ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        margin: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            // name field
                            textFeld(
                              hintText: "Enter Your Name",
                              icon: Icons.account_circle,
                              inputType: TextInputType.name,
                              maxLines: 1,
                              controller: nameController,
                            ),

                            // email
                            textFeld(
                              hintText: "Enter Your Name",
                              icon: Icons.email,
                              inputType: TextInputType.emailAddress,
                              maxLines: 1,
                              controller: emailController,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.90,
                        child: CustomButton(
                          text: "Continue",
                          onPressed: () => storeData(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Color.fromARGB(255, 0, 139, 32),
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Color.fromARGB(255, 0, 139, 32),
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.green.shade50,
          filled: true,
        ),
      ),
    );
  }

  // store user data to database
  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      profilePic: "",
      createdAt: "",
      phoneNumber: "",
      uid: "",
    );
    if (image != null) {
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        profilePic: image!,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyHomePage(),
                          ),
                          (route) => false),
                    ),
              );
        },
      );
    } else {
      showSnackBar(context, "Please upload your profile photo");
    }
  }
}
