import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ice_ai/controllers/conversation_controller.dart';
import 'package:ice_ai/controllers/history_controller.dart';

class HistoryDrawer extends StatelessWidget {
  final HistoryController controller =
      Get.put(HistoryController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .85,
      backgroundColor: Theme.of(context).primaryColor,
      child: GetBuilder<HistoryController>(
        init: HistoryController(),
        builder: (_) => ReorderableListView.builder(
          header: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "HISTORY",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton.icon(
                        onPressed: () {
                          Get.back();
                          Get.find<ConversationController>().delete;
                        },
                        icon: Icon(
                          Icons.add_comment_rounded,
                          size: 22,
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        label: Text(
                          "New Chat",
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                  ),
                  Divider(
                    color: Theme.of(context).colorScheme.background,
                    thickness: 1,
                  )
                ],
              )),
          itemBuilder: ((context, index) => _.histories[index].isEditing
              ? Container(
                  key: ValueKey(index),
                  margin: EdgeInsets.all(8),
                  child: _AssignTitleTextField(index),
                )
              : GestureDetector(
                  key: ValueKey(index),
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.message_rounded,
                        size: 22,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                    title: Text(
                      _.histories[index].title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  onDoubleTap: () => _.onPressTile(index),
                )),
          itemCount: _.histories.length,
          onReorder: (oldIndex, newIndex) => _.updateOrder(oldIndex, newIndex),
        ),
      ),
    );
  }
}

class _AssignTitleTextField extends GetWidget<HistoryController> {
  final int index;
  _AssignTitleTextField(this.index);
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: TextEditingController(),
        maxLines: 1,
        maxLength: 20,
        cursorColor: Theme.of(context).colorScheme.surface,
        cursorWidth: 1.5,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface, width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          hintText: 'Type here',
          hintStyle: Theme.of(context).textTheme.bodySmall,
        ),
        onSubmitted: (v) => controller.onTitleUpdate(index, v));
  }
}
