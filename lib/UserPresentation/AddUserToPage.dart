import 'package:bloc_pattern/Todo/bloc/todo_bloc.dart';
import 'package:bloc_pattern/Todo/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Home/Services/todo.dart';
import '../Presentation/Sacaffold.dart';

class AddUserToPage extends StatefulWidget {
  AddUserToPage(
      {Key? key, required this.username_field, required this.TodayDate})
      : super(key: key);
  final String username_field;
  final String TodayDate;

  @override
  State<AddUserToPage> createState() => _AddUserToPageState();
}

class _AddUserToPageState extends State<AddUserToPage> {
  final cat = TextEditingController();

  final pass = TextEditingController();

  final title = TextEditingController();

  // ignore: unnecessary_brace_in_string_interps
  final notes = TextEditingController();

  final username = TextEditingController();

  bool notes_validate = false;
  bool pass_validate = false;
  bool username_validate = false;
  bool cat_validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ENTRY RECORD"),
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (context) =>
            TodoBloc(RepositoryProvider.of<TodoService>(context)),
        child: BlocBuilder<TodoBloc, TodoState>(builder: (context, state) {
          if (state is AddTodo) {
            return Container();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: cat,
                    decoration: InputDecoration(
                      labelText: "Category",
                      errorText:
                          cat_validate ? "Category can't be Empty" : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: TextField(
                          controller: username,
                          decoration: InputDecoration(
                            labelText: "Username",
                            errorText: username_validate
                                ? "Username can't be Empty"
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          // obscureText: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.2,
                        child: TextField(
                          controller: pass,
                          decoration: InputDecoration(
                            labelText: "Password",
                            errorText: pass_validate
                                ? "Password can't be Empty"
                                : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          // obscureText: true,
                        ),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  maxLines: 5,
                  controller: notes..text = widget.TodayDate,
                  decoration: InputDecoration(
                    labelText: "Add Notes here",
                    errorText: notes_validate ? "Notes can't be Empty" : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => TodosList(
                                  username: widget.username_field,
                                )));
                      },
                      child: Text("CANCEL"),
                    ),
                    SizedBox(width: 20),
                    Container(
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (notes.text.isEmpty) {
                                  notes_validate = true;
                                } else {
                                  notes_validate = false;
                                }
                                if (pass.text.isEmpty) {
                                  pass_validate = true;
                                } else {
                                  pass_validate = false;
                                }
                                if (cat.text.isEmpty) {
                                  cat_validate = true;
                                } else {
                                  cat_validate = false;
                                }
                                if (username.text.isEmpty) {
                                  username_validate = true;
                                } else {
                                  username_validate = false;
                                }
                              });
                              if (!notes_validate &&
                                  !pass_validate &&
                                  !username_validate &&
                                  !cat_validate) {
                                ShowScaffold(context, "Added to the List ");
                                BlocProvider.of<TodoBloc>(context).add(
                                    AddTodosEvent(
                                        widget.username_field,
                                        cat.text,
                                        pass.text,
                                        notes.text,
                                        username.text));
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => TodosList(
                                              username: widget.username_field,
                                            )));
                              }
                            },
                            child: const Text("Save"))),
                  ],
                ),
              ]),
            ),
          );
        }),
      ),
    );
  }
}

void test(String name, bool validation) {
  if (name == "") {
    validation = true;
  }
}
