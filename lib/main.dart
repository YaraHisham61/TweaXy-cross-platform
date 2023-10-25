import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/views/login_view_page1.dart';

void main() {
  runApp(const MyApp());
}

class MainMaterialApp extends StatelessWidget {
  const MainMaterialApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(
          child: Builder(builder: (BuildContext builderContext) {
            return CustomButton(
              initialEnabled: true,
              onPressedCallback: () {
                Navigator.push(builderContext,
                    MaterialPageRoute(builder: (context) {
                  return LoginViewPage1();
                }));
              },
              text: 'Login',
              color: Colors.black,
            );
          }),
        )));
  }
}
