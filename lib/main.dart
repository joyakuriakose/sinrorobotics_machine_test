import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sinrorobotics_machine_test/utils/routes.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Title', // Set your app title
      theme: ThemeData(
        primaryColor: Colors.blue, // Primary app color
        unselectedWidgetColor: Colors.blue, // Color for unselected widgets (e.g., checkboxes)
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.all(Colors.green), // Checkbox background color when checked
          checkColor: MaterialStateProperty.all(Colors.black), // Tick mark color
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), // Rounded corners
        ),
      ),
      initialRoute: Routes.splash, // Ensure you have defined your routes
      getPages: Routes.routes,
    );
  }
}

