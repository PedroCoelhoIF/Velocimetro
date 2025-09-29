import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocimetro/viewmodels/speedmeter_viewmodel.dart';
import 'package:velocimetro/views/speedmeter_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SpeedometerViewModel(),
      child: MaterialApp(
        title: 'Velocímetro GPS',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const SpeedometerScreen(),
      ),
    );
  }
}
