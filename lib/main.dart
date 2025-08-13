import 'package:flutter/material.dart';
import 'package:grabit/core/di/sevice_locator.dart';
import 'package:grabit/core/routes/app_routes.dart';
import 'package:grabit/features/home/viewmodel/home_viewmodel.dart';
import 'package:grabit/features/main/viewmodel/main_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  
  runApp(const GrabItApp());
}

class GrabItApp extends StatelessWidget {
  const GrabItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainViewModel()),
        ChangeNotifierProvider(create: (_)=> HomeViewModel()..loadHomeData())
      ],
      child: MaterialApp(
        title: 'GrabIt',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        initialRoute: Routes.main,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}