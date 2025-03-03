// import 'package:flutter/material.dart';

// class EditableDialogPage extends StatefulWidget {
//   String email;
//   EditableDialogPage(this.email, {super.key});
//   @override
//   _EditableDialogPageState createState() => _EditableDialogPageState();
// }

// class _EditableDialogPageState extends State<EditableDialogPage> {
//   late String _textValue;
//   @override
//   void initState() {
//     super.initState();
//     _textValue = widget.email; // Assign constructor value to state
//   }
//   void _updateValue(String newValue) {
//     setState(() {
//       _textValue = newValue; // Update state value
//     });
//   }

//     TextEditingController textController =
//         TextEditingController(text: _textValue);

//     @override
//     Widget build(BuildContext context) {
//       return AlertDialog(
//         title: Text("Edit Value"),
//         content: TextField(
//           controller: _textController,
//           decoration: InputDecoration(
//             hintText: "Enter new value",
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context), // Close dialog
//             child: Text("Cancel"),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 _textValue = _textController.text; // Update state
//               });
//               Navigator.pop(context); // Close dialog
//             },
//             child: Text("Save"),
//           ),
//         ],
//       );
//     }
//   }
// }
