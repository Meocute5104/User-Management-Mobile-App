import 'package:flutter/material.dart';
import 'package:user_management_app/models/user.dart';
import 'package:user_management_app/models/user.dart';
import 'package:user_management_app/screens/view_user.dart';
import 'package:user_management_app/services/userService.dart';
import 'package:flutter/material.dart';
import '../screens/add_user.dart';
import '../screens/edit_user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<User> _userList = <User>[];
  final _userService = UserService();

  getAllUsers() async {
    var users = await _userService.readAllUsersData();

    List<User> tempList = [];

    users.forEach((user) {
      var userModel = User();
      userModel.id = user['id'];
      userModel.name = user['name'];
      userModel.contact = user['contact'];
      userModel.description = user['description'];
      tempList.add(userModel);
    });

    setState(() {
      _userList = tempList;
    });
  }

  @override
  void initState() {
    //TODO: implement initState
    getAllUsers();
    super.initState();
  }

  _showSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  deleteDataDialog(BuildContext context, userId) {
    return showDialog(
      context: context,
      builder: (params) {
        return AlertDialog(
          title: Text("Are you sure to delete it?"),
          content: Text("Are you sure you want to delete this user?"),
          actions: [
            ElevatedButton(
              child: Text("Delete"),
              onPressed: () async {
                var result = await _userService.delteUser(userId);
                setState(() {
                  if (result != null) {
                    Navigator.pop(context);
                    getAllUsers();
                    _showSnackBar("User has been deleted!");
                  } else {
                    _showSnackBar("Something went wrong!");
                  }
                });
              },
            ),
            ElevatedButton(
              child: Text("Cancle"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "SQLite CRUD App",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: _userList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ViewUser(user: _userList[index]),
                  ),
                );
              },
              leading: Icon(Icons.person),
              title: Text(_userList[index].name ?? ''),
              subtitle: Text(_userList[index].contact ?? ''),
              trailing: SizedBox(
                width: 150.0,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditUser(user: _userList[index]),
                              ),
                            )
                            .then((data) {
                              if (data != null) {
                                getAllUsers();
                                _showSnackBar("User has been updated!");
                              }
                            });
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        deleteDataDialog(context, _userList[index].id);
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => AddUser()));

          if (result != null && result > 0) {
            getAllUsers();
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
