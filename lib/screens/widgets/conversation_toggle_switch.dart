import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ice_ai/controllers/conversation_controller.dart';

class ControlAnimationToggleSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: GetBuilder<ConversationController>(
        builder: (_) => Tooltip(
          message: "I.C.E animation",
          child: Switch(
            value: _.isAnimate,
            activeColor: Theme.of(context).colorScheme.surface,
            onChanged: (v) => _.updateIsAnimate(v),
          ),
        ),
      ),
    );
  }
}
