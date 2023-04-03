import 'dart:convert';

import 'package:get/get.dart';
import 'package:ice_ai/domains/apis/open_ai.dart';
import 'package:ice_ai/models/remove_markdown.dart';

import 'package:ice_ai/models/serializations/history_model.dart';
import 'package:uuid/uuid.dart';

class HistoryController extends GetxController {
  List<HistoryModel> histories = [];
  final OpenAI _openAI = OpenAI();

  /// generate new uuid4
  String get _uuid {
    Uuid uuid = const Uuid();
    String uuid4 = uuid.v4();
    return uuid4;
  }

  void updateOrder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final String title = histories.removeAt(oldIndex).title;
    HistoryModel historyModel =
        HistoryModel(uuid: histories[newIndex].uuid, title: title);
    histories.insert(newIndex, historyModel);
    update();
  }

  Future<void> createHistory(String content) async {
    var res = await _openAI.pickRelevantTitle(content);
    if (res != null) {
      if (res.statusCode >= 200 && res.statusCode < 400) {
        print(res.statusCode);
        var body = json.decode(res.body);
        String plainString =
            removeMarkdownSyntax(body["choices"][0]["text"] as String);

        HistoryModel historyModel =
            HistoryModel(uuid: _uuid, title: plainString);
        histories.add(historyModel);
        update();
      } else {
        print(res.statusCode);
        print(res.body);
      }
    }
  }

  void onPressTile(int index) {
    histories[index].isEditing = true;
    update();
  }

  void onTitleUpdate(int index, String v) {
    if (v.isNotEmpty) {
      histories[index].title = v;
    }
    histories[index].isEditing = false;
    update();
  }
}
