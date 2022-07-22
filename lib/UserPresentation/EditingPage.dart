// ignore_for_file: must_be_immutable

import 'package:bloc_pattern/Home/Services/todo.dart';
import 'package:flutter/material.dart';

import '../Todo/todo.dart';

class EditingPage extends StatefulWidget {
  String username;
  String category;
  String password;
  String realuser;
  String title;
  int index;
  final user_con = TextEditingController();
  final cat_con = TextEditingController();
  final pass_con = TextEditingController();
  EditingPage(
      {Key? key,
      required this.username,
      required this.realuser,
      required this.title,
      required this.category,
      required this.password,
      required this.index})
      : super(key: key);

  @override
  State<EditingPage> createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    widget.cat_con.text = widget.category;
    widget.user_con.text = widget.username;
    widget.pass_con.text = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.4,
        child: Column(
          children: [
            Container(
                height: 60,
                color: Colors.blue,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Editing Record",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Georgia")),
                ),
                width: MediaQuery.of(context).size.width),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.6,
                child: TextField(
                  controller: widget.user_con,
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.6,
                child: TextField(
                  controller: widget.pass_con,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.6,
                child: TextField(
                  controller: widget.cat_con,
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: "Notes",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  // obscureText: true,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel")),
                const SizedBox(width: 20),
                ElevatedButton(
                    onPressed: () {
                      TodoService.update(
                          widget.realuser,
                          widget.title,
                          widget.pass_con.text,
                          widget.cat_con.text,
                          widget.user_con.text,
                          widget.index);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TodosList(username: widget.realuser)),
                        (route) => false,
                      );
                    },
                    child: const Text("  Save  ")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
