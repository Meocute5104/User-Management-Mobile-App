import 'package:flutter/material.dart';
import '../services/userService.dart';
import '../models/user.dart';

class ViewUser extends StatefulWidget {
  final User user;

  const ViewUser({Key? key, required this.user}) : super(key: key);

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "View User",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        height: 170,
        padding: EdgeInsets.all(15.0),
        child: Card(
          elevation: 10, //shadow card
          color: Colors.blueAccent,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "ID: ",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      widget.user.id.toString() ?? "",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Name: ",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(widget.user.name ?? "", style: TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Contact: ",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      widget.user.contact ?? "",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Description: ",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Text(
                      widget.user.description ?? "",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
