// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:provider_app/list_controller.dart';

// class SecondPage extends StatefulWidget {
//   const SecondPage({
//     super.key,
//   });

//   @override
//   State<SecondPage> createState() => _SecondPageState();
// }

// class _SecondPageState extends State<SecondPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ListController>(
//       builder:
//           (BuildContext context, ListController controller, Widget? child) {
//         return Scaffold(
//           floatingActionButton: FloatingActionButton(
//             onPressed: () {
//               // controller.addNumber();
//             },
//             child: const Icon(
//               Icons.add,
//               color: Colors.red,
//             ),
//           ),
//           appBar: AppBar(
//             backgroundColor: Colors.yellow,
//             title: const Text(
//               "Home Page",
//             ),
//             centerTitle: true,
//           ),
//           body: Column(
//             children: [
//               Text(
//                 // controller.numbers.last.toString(),
//                 style: const TextStyle(fontSize: 20),
//               ),
//               SizedBox(
//                 height: 300,
//                 child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: controller.numbers.length,
//                     itemBuilder: (context, index) {
//                       int nums = controller.numbers[index];
//                       return Text(
//                         nums.toString(),
//                         style: const TextStyle(fontSize: 20),
//                       );
//                     }),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Back"),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
