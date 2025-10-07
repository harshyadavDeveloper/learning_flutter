import 'package:flutter/material.dart';
import 'package:provider_app/user_model.dart';

class UserDetails extends StatelessWidget {
  // ADDED: Constructor to receive user name
  final UserModel user;

  const UserDetails({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    print("Image Url : ${user.avatar}");
    return Scaffold(
      // ADDED: AppBar with back button (automatic)
      appBar: AppBar(
        title: const Text("User Details"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ADDED: User profile section
            // Harsh
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.avatar!),
                radius: 50,
              ),
            ),
            const SizedBox(height: 20),

            // ADDED: User details
            Text(
              "Name: ${user.name}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Text(
              "Address: ${user.address}",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),

            // ADDED: Simple back button (optional since AppBar has one)
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Go back to previous page
              },
              child: const Text("Go Back"),
            ),
          ],
        ),
      ),
    );
  }
}
