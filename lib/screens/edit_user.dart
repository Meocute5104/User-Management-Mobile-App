import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/userService.dart';

class EditUser extends StatefulWidget {
  final User user;

  const EditUser({Key? key, required this.user}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var _userService = UserService();
  @override

  void initState() {
    //TODO: implement initState

    nameController.text = widget.user.name ?? '';
    contactController.text = widget.user.contact ?? '';
    descriptionController.text = widget.user.description ?? '';
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Update User",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter Name",
                labelText: "Name",
              ),
            ),
            SizedBox(height: 15.0),
            TextField(
              controller: contactController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter Contact",
                labelText: "Contact",
              ),
            ),
            SizedBox(height: 15.0),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: "Enter Description",
                labelText: "Description",
              ),
            ),
            SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      updateData();
                    },
                    child: Text("Update")
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                    onPressed: () {},
                    child: Text("Reset")
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future updateData() async{
    var user = User();
    user.id = widget.user.id;
    user.name = nameController.text;
    user.contact = contactController.text;
    user.description = descriptionController.text;

    var result = await _userService.updateUser(user);
    Navigator.pop(context, result); // return to home screen
    print("Update user successfully!");
    // print("Result: $result");
  }
}
