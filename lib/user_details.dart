import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/list_controller.dart';
import 'package:provider_app/user_model.dart';

class UserDetails extends StatefulWidget {
  // ADDED: Constructor to receive user name
  final String userId;

  const UserDetails({super.key, required this.userId});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  UserModel? user;
  bool _isLoading = true;

  Future<void> _fetchUserById() async {
    final controller = Provider.of<ListController>(context, listen: false);
    final fetchedUser = await controller.getUserById(widget.userId);
    setState(() {
      user = fetchedUser;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUserById();
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("Image Url : ${user.avatar}");
    return Scaffold(
      // ADDED: AppBar with back button (automatic)
      appBar: AppBar(
        title: const Text("User Details"),
        backgroundColor: Colors.redAccent,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ADDED: User profile section
                  // Harsh
                  Center(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user?.avatar ?? ""),
                      radius: 50,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // ADDED: User details
                  Text(
                    "Name: ${user?.name}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    "Address: ${user?.address}",
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
