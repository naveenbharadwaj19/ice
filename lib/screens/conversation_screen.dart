import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get/get.dart';
import 'package:ice_ai/controllers/conversation_controller.dart';
import 'package:ice_ai/screens/widgets/conversation_toggle_switch.dart';

import 'widgets/conversation_widget.dart';


class ConversationScreen extends StatelessWidget {
  final ConversationController controller = Get.put(ConversationController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 50,
              expandedHeight: 70,
              centerTitle: true,
              title: Text(
                'I.C.E',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              actions: [ControlAnimationToggleSwitch()],
            ),
            _Intro(),
            _Conversations(),
            TypeBox()
          ],
        ),
      ),
    );
  }
}

class _Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Image.asset(
              "assets/images/ice-cubes.png",
              height: 150,
              width: 150,
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Text(
                "I.C.E",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Text(
                "Intelligent,Cognitive,Enterprise",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Text(
                "Powered by Open AI",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Conversations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<ConversationController>(
        init: ConversationController(),
        builder: (_) => SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    if (_.conversations[index].user != null) ...[
                      _MarkDownMessage(
                        _.conversations[index].user!.content,
                        backgroundColor: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(0.9),
                        textColor: Theme.of(context).primaryColor,
                        currentDateTime:
                            _.conversations[index].user!.currentDateTime,
                      )
                    ],
                    if (_.conversations[index].ice != null) ...[
                      !_.isAnimate
                          ? _MarkDownMessage(
                              _.conversations[index].ice!.content,
                              bubbleNip: BubbleNip.leftBottom,
                              currentDateTime:
                                  _.conversations[index].ice!.currentDateTime,
                            )
                          : TypeWriterMarkDown(
                              index,
                              _.conversations[index].ice!.currentDateTime,
                            ),
                    ]
                  ],
                ),
                childCount: _.conversations.length,
              ),
            ));
  }
}

class _MarkDownMessage extends StatelessWidget {
  final String data;
  final Color? backgroundColor;
  final BubbleNip? bubbleNip;
  final Color? textColor;
  final String? currentDateTime;

  _MarkDownMessage(this.data,
      {this.backgroundColor,
      this.bubbleNip,
      this.textColor,
      this.currentDateTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Bubble(
        color: backgroundColor ?? Theme.of(context).colorScheme.tertiary,
        stick: true,
        nip: bubbleNip ?? BubbleNip.rightBottom,
        child: Markdown(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          selectable: true,
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
            codeblockDecoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
            ),
            code: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Theme.of(context).primaryColor),
            p: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: textColor),
          ),
          padding: const EdgeInsets.all(5),
          data: "$data\n \n \n ${currentDateTime ?? ""}",
        ),
      ),
    );
  }
}

class TypeWriterMarkDown extends GetWidget<ConversationController> {
  final int index;
  final String currentDateTime;
  TypeWriterMarkDown(this.index, this.currentDateTime);

  String handleContentAnimation() {
    if (controller.iceContent.value !=
        controller.conversations[index].ice!.content) {
      // ignore: lines_longer_than_80_chars
      return "${controller.conversations[index].ice!.content}\n \n \n $currentDateTime";
    }
    return "${controller.conversations[index].ice!.content.substring(
        // ignore: lines_longer_than_80_chars
        0, controller.iceContentCount.value + 1 < controller.conversations[index].ice!.content.length ?
            // ignore: lines_longer_than_80_chars
            controller.iceContentCount.value + 1 :
            // ignore: lines_longer_than_80_chars
            controller.conversations[index].ice!.content.length)}\n \n \n $currentDateTime";
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.all(8),
        child: Bubble(
          color: Theme.of(context).colorScheme.tertiary,
          stick: true,
          nip: BubbleNip.rightBottom,
          child: Markdown(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            selectable: true,
            styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                .copyWith(
                    codeblockDecoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                    ),
                    code: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Theme.of(context).primaryColor),
                    p: Theme.of(context).textTheme.bodySmall),
            padding: const EdgeInsets.all(5),
            data: handleContentAnimation(),
          ),
        ),
      ),
    );
  }
}
