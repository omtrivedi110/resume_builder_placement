import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResumeController extends GetxController {
  RxList resumeItems = [
    {
      'name': "Skill",
      'item': [],
    },
    {
      'name': "Hobby",
      'item': [],
    },
    {
      'name': "Professional Experience",
      'item': [],
    },
    {
      'name': "Certificates",
      'item': [],
    }
  ].obs;

  RxList itemList = [].obs;

  removeItem({required TextEditingController controller}) {
    itemList.remove(controller);
  }

  addResumeItem({required Map<String, dynamic> data}) {
    resumeItems.add(data);
  }

  deleteResumeItem({required int index}) {
    resumeItems.removeAt(index);
  }
}
