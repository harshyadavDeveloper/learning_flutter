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

  final List<Map<String, String>> roles = [
    {"id": "1", "name": "Admin"},
    {"id": "2", "name": "Manager"},
    {"id": "3", "name": "User"},
    {"id": "4", "name": "Customer"},
  ];

  final List<Map<String, String>> countries = [
    {"id": "1", "name": "India"},
    {"id": "2", "name": "USA"},
    {"id": "3", "name": "China"},
    {"id": "4", "name": "Japan"},
  ];

  final List<Map<String, dynamic>> departments = [
    {"id": "101", "name": "HR"},
    {"id": "201", "name": "Engineering"},
    {"id": "302", "name": "Testing"},
    {"id": "405", "name": "Sales"},
  ];
  dynamic selectedCountry;
  dynamic selectedRole;
  dynamic selectedDepartment;
  String? selectedUserId;

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
                // ==================== Country Dropdown ====================
                const Text("Select Country",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),

                DropdownButtonFormField(
                    initialValue: selectedCountry,
                    hint: const Text("Select a Country"),
                    items: countries.map((country) {
                      return DropdownMenuItem(
                        value: country['id'],
                        child: Text(country['name']!),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCountry = value;
                      });
                      final country =
                          countries.firstWhere((e) => e['id'] == value);
                      print("Selected country name: ${country['name']}");
                      print("Selected country id: ${country['id']}");
                    }),

                // ["harsh:231", "john:421", "doe:5342"]

                DropdownButtonFormField<String>(
                  initialValue: selectedUserId,
                  hint: const Text("Select a User ID"),
                  items: controller.userList.map((user) {
                    return DropdownMenuItem(
                        value: user.id, child: Text(user.name ?? "No name"));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedUserId = value;
                    });
                    print("selected user id: $value");
                  },
                ),

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
