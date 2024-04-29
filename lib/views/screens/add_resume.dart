import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resume_builder_placement/controllers/resume_controller.dart';
import 'package:resume_builder_placement/modals/resume_item_modal.dart';
import 'package:resume_builder_placement/utils/route_utils.dart';

class AddResume extends StatefulWidget {
  const AddResume({super.key});

  @override
  State<AddResume> createState() => _AddResumeState();
}

class _AddResumeState extends State<AddResume> {
  ResumeController resumeController = Get.put(ResumeController());

  TextEditingController newField = TextEditingController();

  File? tmpImg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '1',
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Add New Field"),
                      content: TextField(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                          controller: newField),
                      actions: [
                        OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel")),
                        ElevatedButton(
                            onPressed: () {
                              resumeController.addResumeItem(
                                  data: <String, Object>{
                                    'name': newField.text,
                                    'item': []
                                  });
                              Navigator.pop(context);
                            },
                            child: const Text("Add"))
                      ],
                    );
                  });
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            heroTag: '2',
            onPressed: () {
              resumeController.file == null
                  ? Get.snackbar("Please Click an Image", "Pick an Image !!")
                  : Get.toNamed(MyRoutes.resume_screen);
            },
            child: const Icon(Icons.save),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text("Add Resume"),
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    foregroundImage: (resumeController.file == null
                        ? null
                        : FileImage(resumeController.file!)),
                    radius: 60,
                  ),
                  Positioned(
                      left: 85,
                      top: 60,
                      child: IconButton(
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Choose Method ?"),
                                    actions: [
                                      OutlinedButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            ImagePicker img = ImagePicker();
                                            XFile? file = await img.pickImage(
                                                source: ImageSource.camera);
                                            file == null
                                                ? null
                                                : resumeController.file =
                                                    File(file.path);
                                            file == null
                                                ? null
                                                : tmpImg = File(file.path);
                                          },
                                          child: const Text("Camera")),
                                      ElevatedButton(
                                          onPressed: () async {
                                            Navigator.pop(context);
                                            ImagePicker img = ImagePicker();
                                            XFile? file = await img.pickImage(
                                                source: ImageSource.gallery);
                                            file == null
                                                ? null
                                                : resumeController.file =
                                                    File(file.path);
                                            file == null
                                                ? null
                                                : tmpImg = File(file.path);
                                          },
                                          child: const Text("Gallery"))
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.camera,
                            color: Colors.white,
                          )))
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Om Trivedi",
                    labelText: "Name"),
                onChanged: (val) {
                  resumeController.name.value = val.toString();
                },
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Flutter Developer",
                  labelText: "Job Role",
                ),
                onChanged: (val) {
                  resumeController.role.value = val.toString();
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      ResumeItemModal resumeItemModal = ResumeItemModal(
                          resumeController.resumeItems.value[index]['name'],
                          resumeController.resumeItems.value[index]['item']);
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Get.toNamed(MyRoutes.itemDetail, arguments: index);
                          },
                          title: Text(resumeItemModal.name),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: const Text("Delete"),
                                onTap: () {
                                  resumeController.deleteResumeItem(
                                      index: index);
                                },
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  resumeController.moveUp(index: index);
                                },
                                enabled: index != 0,
                                child: const Text("Move Up"),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  resumeController.moveDown(index: index);
                                },
                                enabled: index !=
                                    (resumeController.resumeItems.value.length -
                                        1),
                                child: const Text("Move Down"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, ind) => const Divider(),
                    itemCount: resumeController.resumeItems.value.length),
              ),
            ],
          ),
        );
      }),
    );
  }
}
