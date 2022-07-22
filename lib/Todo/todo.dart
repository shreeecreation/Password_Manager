// ignore_for_file: unnecessary_new
import 'package:bloc_pattern/Home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../Home/Services/todo.dart';
import '../UserPresentation/AddUserToPage.dart';
import '../UserPresentation/ShowUserPage.dart';
import 'bloc/todo_bloc.dart';

class TodosList extends StatelessWidget {
  final String username;
  const TodosList({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        LogOutPop(context);
        return new Future(() => false);
      },
      child: Scaffold(
        appBar: AppBar(
            title: const Text("Your Passwords"),
            backgroundColor: Colors.orange,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      LogOutPop(context);
                    },
                    icon: Icon(Icons.logout)),
              ),
            ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // DateTime now = new DateTime.now();
            String now = DateFormat("yyyy-MM-dd").format(DateTime.now());
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddUserToPage(
                      TodayDate: now.toString(),
                      username_field: username,
                    )));
          },
          child: const Icon(Icons.add),
        ),
        body: BlocProvider(
            create: (context) =>
                TodoBloc(RepositoryProvider.of<TodoService>(context))
                  ..add(LoadTodosEvent(username)),
            child:
                BlocConsumer<TodoBloc, TodoState>(listener: (context, state) {
              if (state is AddTodo) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TodosList(
                          username: username,
                        )));
              }
            }, builder: (context, state) {
              if (state is TodosLoadedState) {
                return ListView(
                  children: [
                    ...state.tasks.map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Card(
                          child: Container(
                            height: 80,
                            child: ListTile(
                              tileColor: Colors.blue[50],
                              title: Text((e.name).toUpperCase(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Georgia")),
                              subtitle: const Text("See Records !"),
                              leading: const Icon(Icons.key),
                              onTap: () {
                                int index = (e.key);
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UserDataPage(
                                    username: e.cat, //cat is username
                                    password: e.pass, // pass is pass
                                    notes: e.notes,
                                    cat: e.name, index: index,
                                    realuser: username,
                                  ),
                                ));
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    ListTile(title: const Text("RECORD END"), onTap: () {}),
                  ],
                );
              }
              if (state is EmptyState) {
                return const Center(child: Text("The Field is Empty"));
              }
              return Container();
            })),
      ),
    );
  }
}

void LogOutPop(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: Text("WARNING !"),
              content: Text(" Do you sure want to Logout ?"),
              actions: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('CANCEL'),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                      (route) => false,
                    );
                  },
                  child: Text('LOG OUT'),
                  style: OutlinedButton.styleFrom(
                    primary: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ]));
}
