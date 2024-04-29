import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder_placement/controllers/resume_controller.dart';
import 'package:resume_builder_placement/modals/resume_item_modal.dart';

class ResumeItemDetail extends StatefulWidget {
  const ResumeItemDetail({super.key});

  @override
  State<ResumeItemDetail> createState() => _ResumeItemDetailState();
}

class _ResumeItemDetailState extends State<ResumeItemDetail> {
  @override
  ResumeController resumeController = Get.put(ResumeController());
  int index = Get.arguments;
  late ResumeItemModal resumeItemModal;
  @override
  void initState() {
    log("Init state Called");
    resumeItemModal = ResumeItemModal(
        resumeController.resumeItems[index]['name'],
        resumeController.resumeItems[index]['item']);
    resumeItemModal.item.forEach((element) {
      log("Start $element");
    });
    resumeItemModal.item.forEach((e) {
      resumeController.itemList.add(TextEditingController(text: e.toString()));
    });
    resumeController.itemList.add(TextEditingController());
    super.initState();
  }

  @override
  void dispose() {
    resumeController.resumeItems[index]['item'].clear();
    resumeController.itemList.value.forEach((e) {
      e.text == '' || e.text == null
          ? null
          : resumeController.resumeItems[index]['item'].add(e.text);
    });
    resumeController.resumeItems[index]['item'].forEach((e) {
      log(e.toString());
    });
    resumeController.itemList.clear();
    log("Item LIst  ${resumeController.itemList}");
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(resumeItemModal.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return ListView(
            children: [
              ...resumeController.itemList.value.map((e) => Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                border: OutlineInputBorder()),
                            controller: e,
                            onChanged: (val) {},
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              resumeController.removeItem(controller: e);
                            },
                            icon: const Icon(CupertinoIcons.delete))
                      ],
                    ),
                  )),
              const SizedBox(height: 5),
              ElevatedButton(
                  onPressed: () {
                    resumeController.itemList.add(TextEditingController());
                  },
                  child: const Icon(Icons.add))
            ],
          );
        }),
      ),
    );
  }
}
