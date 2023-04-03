import 'package:get/get.dart';
import 'package:ice_ai/screens/conversation_screen.dart';

List<GetPage<dynamic>> getPages = [
  GetPage(
    name: "/conversation",
    page: () => ConversationScreen(),
  ),
];
