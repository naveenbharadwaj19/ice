import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:ice_ai/configs/routes.dart';
import 'package:ice_ai/configs/theme.dart';
import 'package:ice_ai/screens/conversation_screen.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          print("Keyboard dismissed");
          currentFocus.unfocus();
        }
      },
      child: GetMaterialApp(
        theme: themeData,
        title: "ICE",
        home: ConversationScreen(),
        getPages: getPages,
      ),
    );
  }
}
