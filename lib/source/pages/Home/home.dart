import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:susu/source/data/Auth/cubit/login_cubit.dart';
import 'package:susu/source/data/Home/cubit/home_cubit.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  // late final AnimationController controllerLottie;
  TextEditingController controller = TextEditingController();
  TextEditingController controllerLogout = TextEditingController();
  final formkey = GlobalKey<FormState>();

  void logout() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Alert'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                  key: formkey,
                  child: TextFormField(
                    controller: controllerLogout,
                    decoration: const InputDecoration(
                      hintText: 'Masukan Password untuk logout',
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Kolom harus di isi";
                      }
                      if (value != 'PASSWORD') {
                        return "Password yang Dimasukan Salah !!";
                      }
                      return null;
                    },
                  )),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Tidak')),
            TextButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    if (controllerLogout.text == 'PASSWORD') {
                      BlocProvider.of<LoginCubit>(context).keluar(context);
                    }
                  }
                },
                child: const Text('Iya')),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<HomeCubit>(context).invetoryIssue();
    // controllerLottie = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('SUSU', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              logout();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 22,
            ),
          ),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        if (constraint.maxWidth >= 600) {
          return ListView(
            children: [
              SizedBox(
                // height: 300,
                width: constraint.maxWidth,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'SCAN ID CARD ANDA',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 200,
                            child: TextFormField(
                              autofocus: true,
                              controller: controller,
                              cursorColor: Colors.white,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (value) async {
                                if (value.length >= 9) {
                                  await Future.delayed(const Duration(milliseconds: 650));
                                  BlocProvider.of<HomeCubit>(context).tukarSusu(controller.text);
                                  controller.clear();
                                }
                              },
                            ),
                          ),
                          BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                            if (state is TukarSusuLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (state is TukarSusuMessage) {
                              return SizedBox(
                                height: 100,
                                child: Center(child: Text(state.message.toString())),
                              );
                            }
                            if (state is TukarSusuLoaded == false) {
                              return Container();
                            }
                            var crId = (state as TukarSusuLoaded).crID;
                            var json = (state as TukarSusuLoaded).json;
                            var statusCode = (state as TukarSusuLoaded).statusCode;
                            if (json!.isEmpty) {
                              return Container();
                            }
                            return result(
                              json[0]['FullName'].toString(),
                              json[0]['department'].toString(),
                              json[0]['bagian'].toString(),
                              json[0]['jml_susu_diterima'].toString(),
                              crId,
                              json[0]['crStr'].toString(),
                            );
                          }),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        child: Lottie.asset(
                          'assets/cow.json',
                          height: 350,
                          repeat: true,
                          animate: true,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        } else {
          return Container(
            child: ListView(
              children: [
                const Text('SCAN ID CARD ANDA'),
                TextFormField(
                  autofocus: true,
                  controller: controller,
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    fontSize: 20,
                    // color: Colors.white,
                  ),
                  decoration: const InputDecoration(border: InputBorder.none),
                  onChanged: (value) async {
                    if (value.length >= 9) {
                      await Future.delayed(const Duration(milliseconds: 650));
                      BlocProvider.of<HomeCubit>(context).tukarSusu(controller.text);
                      controller.clear();
                    }
                  },
                ),
                BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
                  if (state is TukarSusuLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is TukarSusuMessage) {
                    return SizedBox(
                      height: 100,
                      child: Center(child: Text(state.message.toString())),
                    );
                  }
                  if (state is TukarSusuLoaded == false) {
                    return Container();
                  }
                  if (state is TukarSusuLoaded) {
                    var crId = state.crID;
                    var json = state.json;
                    var statusCode = state.statusCode;
                    if (json.isEmpty) {
                      return Container();
                    }
                    if (statusCode == 200) {
                      return result(
                        json[0]['FullName'],
                        json[0]['department'],
                        json[0]['bagian'],
                        json[0]['jml_susu_diterima'].toString(),
                        crId,
                        json[0]['crStr'].toString(),
                      );
                    } else {
                      return Text(json.toString());
                    }
                  }
                  return Container();
                }),
                Container(
                  child: Lottie.asset(
                    'assets/cow.json',
                    height: 350,
                    repeat: true,
                    animate: true,
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

Widget result(fullname, depart, bagian, susu, crID, msg) {
  return Column(
    children: [
      Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1.3,
                spreadRadius: 1.3,
                offset: const Offset(1, 2),
              )
            ],
          ),
          child: Column(
            children: [
              Table(
                columnWidths: const {
                  0: FixedColumnWidth(120),
                  1: FixedColumnWidth(10),
                },
                children: [
                  TableRow(children: [
                    const Text('Nama', style: TextStyle(fontSize: 16)),
                    const Text(':', style: TextStyle(fontSize: 16)),
                    Text(fullname, style: const TextStyle(fontSize: 16)),
                  ]),
                  TableRow(children: [
                    const Text('Department', style: TextStyle(fontSize: 16)),
                    const Text(':', style: TextStyle(fontSize: 16)),
                    Text(depart, style: const TextStyle(fontSize: 16)),
                  ]),
                  TableRow(children: [
                    const Text('Bagian', style: TextStyle(fontSize: 16)),
                    const Text(':', style: TextStyle(fontSize: 16)),
                    Text(bagian, style: const TextStyle(fontSize: 16)),
                  ]),
                  TableRow(children: [
                    const Text('Jumlah Susu diterima', style: TextStyle(fontSize: 16)),
                    const Text(':', style: TextStyle(fontSize: 16)),
                    Text(susu, style: const TextStyle(fontSize: 16)),
                  ]),
                ],
              ),
            ],
          )),
      const SizedBox(height: 8),
      Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        height: 40,
        decoration: BoxDecoration(
          color: crID == 1
              ? Colors.green[700]
              : crID == 4
                  ? Colors.amber[600]
                  : Colors.red[700],
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 1.3,
              spreadRadius: 1.3,
              offset: const Offset(1, 2),
            )
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          crID != 4 ? msg.toString() : "Maaf, Anda Tidak Mendapatkan Jadwal Susu",
          style: TextStyle(color: crID == 4 ? Colors.black : Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    ],
  );
}
