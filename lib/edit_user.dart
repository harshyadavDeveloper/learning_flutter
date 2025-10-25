import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/list_controller.dart';
import 'package:provider_app/user_model.dart';

class EditUserPage extends StatefulWidget {
  final String userId;
  const EditUserPage({super.key, required this.userId});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _avatarController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final controller = Provider.of<ListController>(context, listen: false);

    final user = await controller.getUserById(widget.userId);

    if (user != null) {
      _nameController.text = user.name ?? "N/A";
      _addressController.text = user.address ?? "N/A";
      _avatarController.text = user.avatar ?? "";
      _avatarPreview = user.avatar;
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _updateUser() async {
    if (_formKey.currentState!.validate()) {
      final updatedUser = UserModel(
        name: _nameController.text,
        address: _addressController.text,
        avatar: _avatarController.text,
      );
      final controller = Provider.of<ListController>(context, listen: false);
      controller.updateUser(widget.userId, updatedUser);

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User updated successfully")));

      Navigator.pop(context);
    }
  }

  bool _isLoading = true;
  String? _avatarPreview;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit User Page"),
        backgroundColor: Colors.blueAccent,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                            radius: 50,
                            backgroundImage: _avatarPreview != null
                                ? NetworkImage(_avatarPreview!)
                                : null,
                            child: _avatarPreview == null
                                ? const Icon(
                                    Icons.person,
                                    size: 50,
                                  )
                                : null),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                            labelText: "Name", border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter a username";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _addressController,
                        decoration: const InputDecoration(
                            labelText: "Address", border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter a addrerss";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _avatarController,
                        decoration: const InputDecoration(
                            labelText: "Avatar", border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter a avatar";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                            onPressed: _updateUser,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsetsGeometry.symmetric(
                                  horizontal: 32, vertical: 12),
                            ),
                            child: const Text(
                              "Update User",
                              style: TextStyle(fontSize: 16),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
