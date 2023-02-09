import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:susu/source/data/Auth/cubit/login_cubit.dart';
import 'package:susu/source/data/Home/cubit/home_cubit.dart';
import 'package:susu/source/network/network.dart';
import 'package:susu/source/repository/repository.dart';
import 'package:susu/source/router/router.dart';

void main() {
  runApp(MyApp(
    router: RouterNavigation(),
    myRepository: MyRepository(myNetwork: MyNetwork()),
  ));
}

class MyApp extends StatelessWidget {
  final RouterNavigation? router;
  final MyRepository? myRepository;
  const MyApp({super.key, this.router, this.myRepository});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit(myRepository: myRepository)),
        BlocProvider(create: (context) => LoginCubit(myRepository: myRepository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router!.generateRoute,
      ),
    );
  }
}
