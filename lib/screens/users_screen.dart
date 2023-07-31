import 'package:flutter/material.dart';
import 'package:flutter_appwork_crud/models/request_model_users.dart';
import 'package:flutter_appwork_crud/models/users_model.dart';
import 'package:flutter_appwork_crud/services/users_service.dart';

class HomePageUsers extends StatefulWidget {
  const HomePageUsers({super.key});

  @override
  State<HomePageUsers> createState() => _HomePageUsersState();
}

class _HomePageUsersState extends State<HomePageUsers> {
  final firstController = TextEditingController();
  final lastController = TextEditingController();
  final emailController = TextEditingController();

  List<Users> users = [];
  bool isLoading = false;

  Future<void> refreshData() async {
    setState(() {
      isLoading = true;
    });
    final result = await UsersService().getAll();
    users = result.data;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Users List"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: users.length,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    formData(users[index]);
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(
                          "${users[index].firstName} ${users[index].lastName}"),
                      subtitle: Text(users[index].email),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          formData(null);
        },
        backgroundColor: Colors.amber,
        focusColor: Colors.amber,
        child: const Icon(
          Icons.add,
          size: 24.0,
        ),
      ),
    );
  }

  void formData(Users? users) async {
    if (users != null) {
      firstController.text = users.firstName;
      lastController.text = users.lastName;
      emailController.text = users.email;
    }
    bool confirm = false;
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(users == null ? 'Add' : "Update"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextFormField(
                  controller: firstController,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                    helperText: "What's your first name ?",
                  ),
                  onChanged: (value) {},
                ),
                TextFormField(
                  controller: lastController,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                    helperText: "What's your last name ?",
                  ),
                  onChanged: (value) {},
                ),
                TextFormField(
                  controller: emailController,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                    helperText: "What's your email ?",
                  ),
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          actions: <Widget>[
            if (users != null)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                ),
                onPressed: () async {
                  await UsersService().deleteData(users.id);
                  refreshData();
                  firstController.clear();
                  lastController.clear();
                  emailController.clear();
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                child: const Text("Delete"),
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[600],
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("No"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[300],
              ),
              onPressed: () async {
                confirm = true;
                Navigator.pop(context);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    );

    if (confirm) {
      //print("Confirmed!");
      ReqUser reqUser = ReqUser(
        firstName: firstController.text,
        lastName: lastController.text,
        email: emailController.text,
      );
      if (users == null) {
        await UsersService().addData(reqUser);
      } else {
        await UsersService().updateData(users.id, reqUser);
      }

      firstController.clear();
      lastController.clear();
      emailController.clear();

      await refreshData();
    }
  }
}
