import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Add New Field"),
                  content: TextField(
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                      controller: newField),
                  actions: [
                    OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                    ElevatedButton(
                        onPressed: () {
                          resumeController.addResumeItem(data: <String, Object>{
                            'name': newField.text,
                            'item': []
                          });
                          Navigator.pop(context);
                        },
                        child: const Text("Add")),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Add Resume"),
      ),
      body: Obx(() {
        return ListView.separated(
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
                      PopupMenuItem(child: const Text("Update"), onTap: () {}),
                      PopupMenuItem(
                        child: const Text("Delete"),
                        onTap: () {
                          resumeController.deleteResumeItem(index: index);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, ind) => const Divider(),
            itemCount: resumeController.resumeItems.value.length);
      }),
    );
  }
}
