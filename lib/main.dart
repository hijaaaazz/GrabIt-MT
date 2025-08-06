import 'package:flutter/material.dart';
import 'package:grabit/core/routes/app_routes.dart';
import 'package:grabit/features/main/viewmodel/main_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const GrabItApp());
}

class GrabItApp extends StatelessWidget {
  const GrabItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_)=>MainViewModel())
      ],
      child: MaterialApp(
        title: 'GrabIt',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: Routes.splash,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
