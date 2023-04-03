import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ice_ai/controllers/history_controller.dart';
import 'package:ice_ai/domains/apis/open_ai.dart';
import 'package:ice_ai/models/serializations/conversation_model.dart';

class ConversationController extends GetxController {
  ScrollController scrollController = ScrollController();
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  RxList<ConversationModel> conversations = RxList<ConversationModel>();
  RxInt iceContentCount = 0.obs;
  RxString iceContent = "naveen".obs;
  bool isAnimate = false;

  void updateIsAnimate(bool v) {
    isAnimate = v;
    update();
  }

  void updateIsLoading(bool v) {
    isLoading = v;
    update();
  }

  void get scrollDown {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  String get currentDateTime {
    DateTime now = DateTime.now();
    String formattedDate =
        '${now.day}/${now.month}/${now.year}:${now.hour}:${now.minute}:${now.second}';
    return formattedDate;
  }

  Future<void> _startTyping() async {
    for (int i = 0; i <= conversations.last.ice!.content.length; i++) {
      iceContentCount.value = i;
      await Future.delayed(const Duration(milliseconds: 50));
      scrollDown;
    }
  }

  ///  [conversations]
  /// [controller]
  ///
  /// update [updateIsLoading]
  void get delete {
    conversations.clear();
    controller.clear();
    updateIsLoading(false);
  }

  final OpenAI _openAI = OpenAI();

  Future<void> send(GlobalKey<FormState> form) async {
    if (form.currentState!.validate()) {
      updateIsLoading(true);
      _createHistory();
      ConversationModel conversation = ConversationModel(
          user: MessagesModel(
              content: controller.text, currentDateTime: currentDateTime));
      conversations.add(conversation);
      var res = await _openAI.chatCompletion(controller.text);
      if (res != null) {
        if (res.statusCode < 400) {
          print(res.statusCode);
          var body = json.decode(res.body);
          String content = body["choices"][0]["message"]["content"] as String;
          conversations.last.ice =
              MessagesModel(content: content, currentDateTime: currentDateTime);
          iceContent.value = content;
          controller.clear();
          conversations.refresh();
          updateIsLoading(false);
          if (isAnimate) {
            _startTyping();
          }
        } else {
          print(res.statusCode);
          print(res.body);
        }
      } else {
        print(res);
      }
    }
  }

  void _createHistory() {
    if (conversations.isEmpty) {
      Get.find<HistoryController>().createHistory(controller.text);
    }
  }


  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
