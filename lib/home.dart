import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/list_controller.dart';
import 'package:provider_app/user_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> users = [
    {
      "id": 1,
      "name": "Alice Johnson",
      "avatar": "https://i.pravatar.cc/150?img=1",
    },
    {
      "id": 2,
      "name": "Bob Smith",
      "avatar": "https://i.pravatar.cc/150?img=2",
    },
    {
      "id": 3,
      "name": "Charlie Brown",
      "avatar": "https://i.pravatar.cc/150?img=3",
    },
    {
      "id": 4,
      "name": "Diana Prince",
      "avatar": "https://i.pravatar.cc/150?img=4",
    },
    {
      "id": 5,
      "name": "Ethan Hunt",
      "avatar": "https://i.pravatar.cc/150?img=5",
    },
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  Future<void> getData() async {
    final controller = Provider.of<ListController>(context, listen: false);
    controller.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ListController>(
      builder: (context, controller, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: const Text(
            "Home Page",
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: controller.userList.length,
          itemBuilder: (context, index) {
            final user = controller.userList[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                onTap: () {
                  // print("User ID: ${user["id"]}");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserDetails(
                                user: user
                              )));
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.avatar!),
                  radius: 25,
                ),
                title: Text(
                  user.name!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text("ID: ${user.name}"),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              ),
            );
          },
        ),
      ),
    );
  }
}
