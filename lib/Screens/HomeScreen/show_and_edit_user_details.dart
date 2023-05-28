import 'package:clouds/Screens/CommonScreens/get_start.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Authentications/provider/authentication_provider.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<UserDetails> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 139, 32),
        title: Text(ap.userModel.name),
        actions: [
          IconButton(
            onPressed: () {
              ap.userSignOut().then(
                    (value) => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const GetStart())),
                        (route) => false),
                  );
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Color.fromARGB(255, 0, 139, 32),
            backgroundImage: NetworkImage(ap.userModel.profilePic),
            radius: 50,
          ),
          const SizedBox(height: 20),
          Text(ap.userModel.name),
          Text(ap.userModel.phoneNumber),
          Text(ap.userModel.email),
        ],
      )),
    );
  }
}
