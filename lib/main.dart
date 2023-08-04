import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_mapbox_flutter/screen/screen.dart';

import 'bloc/gps/gps_bloc.dart';

void main() => runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => GpsBloc())],
      child: const MyApp(),
    ),
  );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoadingScreen(),
    );
  }
}
