import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ice_ai/controllers/conversation_controller.dart';

class TypeBox extends StatefulWidget {
  @override
  State<TypeBox> createState() => _TypeBoxState();
}

class _TypeBoxState extends State<TypeBox> {
  final GlobalKey<FormState> form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      hasScrollBody: false,
      fillOverscroll: true,
      child: GetBuilder<ConversationController>(
        init: ConversationController(),
        builder: (_) => _.isLoading
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 60,
                  padding: const EdgeInsets.all(8.0),
                  child: SpinKitThreeBounce(
                    size: 20,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              )
            : Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 5, left: 10, right: 10, bottom: 20),
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  child: Form(
                    key: form,
                    child: TextFormField(
                      controller: _.controller,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Cannot be empty";
                        }
                        return null;
                      },
                      maxLines: null,
                      maxLength: 500,
                      cursorColor: Theme.of(context).colorScheme.surface,
                      cursorWidth: 8,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        hintText: 'Type here',
                        hintStyle: Theme.of(context).textTheme.bodySmall,
                        suffixIcon: InkWell(
                          child: Icon(
                            Icons.send_rounded,
                            size: 24,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          onTap: () => _.send(form),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
