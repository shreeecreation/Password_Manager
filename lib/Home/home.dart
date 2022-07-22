// ignore_for_file: must_be_immutable

import 'package:bloc_pattern/Home/HomeBloc/bloc/home_bloc.dart';
import 'package:bloc_pattern/Presentation/Sacaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Todo/todo.dart';
import 'Services/authentication.dart';
import 'Services/todo.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final _userField = TextEditingController();
  final _passField = TextEditingController();
  final _recoveryField = TextEditingController();
  final _recoveryFieldforgot = TextEditingController();
  final _passFieldforgot = TextEditingController();
  String recoverypassword = "";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
          RepositoryProvider.of<AuthenticationService>(context),
          RepositoryProvider.of<TodoService>(context))
        ..add(RegisteringServicesEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Password Manager"),
          backgroundColor: Colors.orange,
        ),
        body: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is SuccessLoginState) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => TodosList(
                        username: state.user,
                      )));
              ShowScaffold(context, "Logged in as " + state.user);
            }
          },
          builder: (context, state) {
            if (state is HomeInitial) {
              return SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(height: 30),
                  SizedBox(
                      child: Image.asset(
                    "assets/laptop.png",
                    height: 150,
                    width: 150,
                  )),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(state.error,
                        textAlign: TextAlign.left,
                        style: const TextStyle(color: Colors.red)),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextFields(
                        controller: _userField, LabelText: "Username"),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextField(
                      controller: _passField,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      // obscureText: true,
                    ),
                  ),

                  const SizedBox(height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: TextButton(
                            child: const Text("Forgot Password !",
                                style: TextStyle(color: Colors.blue)),
                            onPressed: () {
                              BlocProvider.of<HomeBloc>(context)
                                  .add(ForgotEvent());
                            }),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () => BlocProvider.of<HomeBloc>(context)
                              .add(
                                  LoginEvent(_userField.text, _passField.text)),
                          child: const Text("Login")),
                      const SizedBox(width: 30),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(RegisterEvent());
                          },
                          child: const Text("Register")),
                    ],
                  ),
                ]),
              );
            }
            if (state is RegisterState) {
              return SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: 30),
                  const SizedBox(
                      child: Icon(Icons.key, size: 90, color: Colors.orange)),
                  SizedBox(height: 30),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextFields(
                        controller: _userField, LabelText: "Username"),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextFields(
                        controller: _passField, LabelText: "Password"),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: TextFields(
                        controller: _recoveryField,
                        LabelText: "Recovery Password"),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Hint ! Add Your Number in Recovery Password Easy to Remember",
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  Text(state.error,
                      textAlign: TextAlign.left,
                      style: const TextStyle(color: Colors.red)),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(RegisteringServicesEvent());
                          },
                          child: const Text("Back")),
                      const SizedBox(width: 30),
                      ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<HomeBloc>(context).add(
                                AccountCreateuser(
                                    _userField.text,
                                    _passField.text,
                                    _recoveryField.text,
                                    context));
                            // _userField.text = "";
                            // _passField.text = "";
                          },
                          child: const Text("Register")),
                    ],
                  ),
                ]),
              );
            }
            if (state is ForgotState) {
              return SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(children: [
                      const SizedBox(height: 30),
                      const SizedBox(
                          child:
                              Icon(Icons.key, size: 90, color: Colors.orange)),
                      const SizedBox(height: 30),

                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: TextFields(
                            controller: _userField, LabelText: "Username"),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.2,
                        child: TextField(
                          controller: _passField,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          // obscureText: true,
                        ),
                      ),
                      const SizedBox(height: 0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: TextButton(
                                child: const Text("Forgot Password !",
                                    style: TextStyle(color: Colors.blue)),
                                onPressed: () {}),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          ElevatedButton(
                              onPressed: null, child: const Text("Login")),
                          const SizedBox(width: 30),
                          ElevatedButton(
                              onPressed: null, child: const Text("Register")),
                        ],
                      ),
                    ]),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: AlertDialog(
                          title: const Text("Recovery Password"),
                          actions: [
                            TextButton(
                                child: const Text("Cancel"),
                                onPressed: () {
                                  _recoveryFieldforgot.text = "";
                                  _passFieldforgot.text = "";
                                  BlocProvider.of<HomeBloc>(context)
                                      .add(RegisteringServicesEvent());
                                }),
                            TextButton(
                                child: const Text("Submit"),
                                onPressed: () {
                                  BlocProvider.of<HomeBloc>(context).add(
                                      RecoverEvent(_passFieldforgot.text,
                                          _recoveryFieldforgot.text));
                                  recoverypassword =
                                      AuthenticationService.GetPassword(
                                          _passFieldforgot.text);
                                })
                          ],
                          content: Column(children: [
                            TextFields(
                                controller: _passFieldforgot,
                                LabelText: "Enter Your Username"),
                            const SizedBox(height: 20),
                            TextFields(
                                controller: _recoveryFieldforgot,
                                LabelText: "Enter Your Recovery"),
                            const SizedBox(height: 10),
                            Text(state.error,
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontFamily: "Georgia",
                                    fontSize: 12)),
                            const SizedBox(height: 10),
                            const Text(
                                "Note: If you don't know recovery password, You have to delete all the data. We can't take a risk of other privacy",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12))
                          ])),
                    ),
                  ],
                ),
              );
            }
            if (state is SuccessForgotState) {
              return Container(
                height: MediaQuery.of(context).size.height / 1.5,
                child: AlertDialog(
                  actions: [
                    Center(
                      child: ElevatedButton(
                        child: Text("Try Login"),
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context)
                              .add(RegisteringServicesEvent());
                          _userField.text = "";
                          _passField.text = "";
                        },
                      ),
                    )
                  ],
                  title: const Text("Success !",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.green)),
                  content: Column(children: [
                    const SizedBox(height: 20),
                    Text("Your Username\n ${_passFieldforgot.text}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                        )),
                    Text("Your Passsword\n ${recoverypassword} ",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                        textAlign: TextAlign.center),
                  ]),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class TextFields extends StatelessWidget {
  final TextEditingController controller;
  final String LabelText;
  TextFields({Key? key, required this.controller, required this.LabelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: LabelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
