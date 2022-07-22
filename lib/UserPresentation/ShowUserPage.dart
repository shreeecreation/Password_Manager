// ignore_for_file: non_constant_identifier_names, must_be_immutable

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

import '../Home/Services/todo.dart';
import '../Presentation/Sacaffold.dart';
import '../Todo/todo.dart';
import 'EditingPage.dart';

class UserDataPage extends StatefulWidget {
  UserDataPage(
      {Key? key,
      required this.username,
      required this.password,
      required this.cat,
      required this.index,
      required this.realuser,
      required this.notes})
      : super(key: key);
  final String realuser;
  final String username;
  final String password;
  final String cat;
  final String notes;
  final int index;

  @override
  State<UserDataPage> createState() => _UserDataPageState();
}

class _UserDataPageState extends State<UserDataPage> {
  final _user = TextEditingController();
  final _pass = TextEditingController();
  final _notes = TextEditingController();

  final textStyle = const TextStyle(
      color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400);

  @override
  Widget build(BuildContext context) {
    _user.text = widget.username;
    _pass.text = widget.password;
    _notes.text = widget.notes;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text(widget.cat == null ? "dasd" : (widget.cat).toUpperCase()),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              ShowUserPageHelper(
                Category1: "Username",
                controller: _user,
                passorwat: false,
                maxlines: 1,
              ),
              const SizedBox(height: 30),
              ShowUserPageHelper(
                Category1: "Password",
                controller: _pass,
                passorwat: true,
                maxlines: 1,
              ),
              const SizedBox(height: 30),
              ShowUserPageHelper(
                Category1: "Notes",
                controller: _notes,
                passorwat: false,
                maxlines: 5,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                child: EditingPage(
                                  category: widget.notes,
                                  password: widget.password,
                                  username: widget.username,
                                  realuser: widget.realuser,
                                  title: widget.cat,
                                  index: widget.index,
                                ),
                              ));
                    },
                    child: const Text("Edit"),
                  ),
                  const SizedBox(width: 30),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Warning"),
                          content: const Text("Do you sure want to delete ?"),
                          actions: [
                            OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  primary: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  TodoService.removeTask(widget.index);
                                  ShowScaffold(
                                      context, "Deleted from the List ");

                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TodosList(
                                            username: widget.realuser)),
                                    (route) => false,
                                  );
                                },
                                child: const Text("Delete")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: const Text("Cancel")),
                          ],
                        ),
                      );
                    },
                    child: const Text("Delete"),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class ShowUserPageHelper extends StatefulWidget {
  final String Category1;
  bool passorwat;
  TextEditingController controller;
  int maxlines;
  ShowUserPageHelper({
    Key? key,
    required this.maxlines,
    required this.Category1, //header
    required this.controller,
    required this.passorwat,
  }) : super(key: key);

  @override
  State<ShowUserPageHelper> createState() => _ShowUserPageHelperState();
}

class _ShowUserPageHelperState extends State<ShowUserPageHelper> {
  bool _password_Visible = false;
  bool issnackbarshowing = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width / 1.3,
          child: TextField(
            readOnly: true,
            obscureText: widget.passorwat ? !_password_Visible : false,
            maxLines: widget.maxlines,
            controller: widget.controller,
            decoration: InputDecoration(
              suffixIcon: widget.passorwat
                  ? IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _password_Visible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _password_Visible = !_password_Visible;
                        });
                      },
                    )
                  : null,
              labelText: widget.Category1,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        IconButton(
            icon: Icon(Icons.copy),
            onPressed: () {
              FlutterClipboard.copy(widget.controller.text).then(
                  (value) => ShowScaffold(context, "Copied to clipboard"));
            }),
        SizedBox(height: 20),
      ],
    );
  }
}
