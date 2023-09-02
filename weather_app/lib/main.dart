import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/Service/supabseApi.dart';
import 'package:weather_app/api_bloc/api_bloc.dart';
import 'package:weather_app/screens/search_screen.dart';

void main() {
  subabaseConfing();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ApiBloc(),
      child: MaterialApp(
        home: SearchScreen(),
      ),
    );
  }
}
