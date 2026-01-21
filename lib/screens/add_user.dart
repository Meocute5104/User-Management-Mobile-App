import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/userService.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  var _formKey = GlobalKey<FormState>(); //To validation -> use Form()



  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var _userService = UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add User",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Form( //To validation -> use Form()
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                validator: (value){
                  if(value!.isEmpty){
                    return "Please enter your name";
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Enter Name",
                  labelText: "Name",
                ),
              ),
              SizedBox(height: 15.0),
              TextFormField(
                controller: contactController,
                validator: (value){
                  if(value!.isEmpty){
                    return "Please enter your contact";
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Enter Contact",
                  labelText: "Contact",
                ),
              ),
              SizedBox(height: 15.0),
              TextFormField(
                controller: descriptionController,
                validator: (value){
                  if(value!.isEmpty){
                    return "Please enter your description";
                  }
                },
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
                        setState(() {
                          if(_formKey.currentState!.validate()){
                            saveData();
                          }
                        });
                      },
                      child: Text("Save")
                  ),
                  SizedBox(width: 10.0),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          nameController.text = "";
                          contactController.text = "";
                          descriptionController.text = "";
                        });
                      },
                      child: Text("Reset")
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future saveData() async{
    var user = User();
    user.name = nameController.text;
    user.contact = contactController.text;
    user.description = descriptionController.text;

    var result = await _userService.saveUser(user);
    Navigator.pop(context, result); // return to home screen
    print("Add user successfully!");
    print("Result: $result");
  }
}
