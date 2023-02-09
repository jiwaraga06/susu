import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:susu/source/data/Auth/cubit/login_cubit.dart';
import 'package:susu/source/widget/customAlertDialog.dart';
import 'package:susu/source/widget/customLoading.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  void submit() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<LoginCubit>(context).login(context, controllerUsername.text, controllerPassword.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF393E46),
        title: Text('LOGIN', style: TextStyle(color: Colors.white)),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return const CustomLoading();
              },
            );
          }
          if (state is LoginLoaded) {
            Navigator.pop(context);
            var json = state.json;
            var message = state.message;
            var statusCode = state.statusCode;
            if (statusCode == 200) {
              if (json.length != 0) {
                if (json[0]['Result'] == 4) {
                  MyAlertDialog.successDialog(context, message, () {});
                } else {
                  MyAlertDialog.warningDialog(context, message);
                }
              } else {
                MyAlertDialog.warningDialog(context, message);
              }
            } else {
              MyAlertDialog.warningDialog(context, json.toString());
            }
          }
        },
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(FontAwesomeIcons.cow, color: Color(0XFF393E46), size: 100),
                    const SizedBox(height: 40),
                    Form(
                      key: _formKey,
                      child: SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: controllerUsername,
                              cursorColor: Color(0XFF393E46),
                              decoration: InputDecoration(
                                hintText: "Masukan Username",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Color(0XFF393E46), width: 2),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Kolom ini tidak boleh kosong";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: controllerPassword,
                              cursorColor: Color(0XFF393E46),
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Masukan Password",
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Color(0XFF393E46), width: 2),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Kolom ini tidak boleh kosong";
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 45,
                      child: OutlinedButton(
                        onPressed: () {
                          submit();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0XFF393E46),
                            elevation: 3.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            )),
                        child: const Text("Submit", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
