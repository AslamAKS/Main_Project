import 'package:clouds/Screens/CommonScreens/custom_button.dart';
import 'package:flutter/material.dart';

import '../../Authentications/PhoneNumberAuthentication/phnopage.dart';

class GetStart extends StatefulWidget {
  const GetStart({super.key});

  @override
  State<GetStart> createState() => _GetStartState();
}

class _GetStartState extends State<GetStart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              // custom button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  text: "Get started",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
