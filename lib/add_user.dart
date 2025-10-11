import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/list_controller.dart';
import 'package:provider_app/user_model.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _avatarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ListController>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add User"),
          backgroundColor: Colors.yellow,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Name"),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter a name" : null,
                ),
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: "Address"),
                  validator: (value) =>
                      value == null || value.isEmpty ? "Enter a address" : null,
                ),
                TextFormField(
                  controller: _avatarController,
                  decoration: const InputDecoration(labelText: "Avatar URL"),
                  validator: (value) => value == null || value.isEmpty
                      ? "Enter a avatar url"
                      : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      // final String name = _nameController.text;
                      // final String address = _addressController.text;
                      // final String avatar = _avatarController.text;
                      if (_formKey.currentState!.validate()) {
                        // final newUser = UserModel(
                        //   name: name,
                        //   address: address,
                        //   avatar: avatar,
                        // );
                        final newUser = UserModel(
                            name: _nameController.text,
                            address: _addressController.text,
                            avatar: _avatarController.text);

                        await controller.addUser(newUser);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Submit")),
              ],
            ),
          ),
        ));
  }
}
