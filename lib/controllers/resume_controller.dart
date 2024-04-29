import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResumeController extends GetxController {
  RxString name = ''.obs;
  RxString role = ''.obs;
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
  File? file;

  removeItem({required TextEditingController controller}) {
    itemList.remove(controller);
  }

  addResumeItem({required Map<String, dynamic> data}) {
    resumeItems.add(data);
  }

  moveUp({required int index}) {
    Map tmpData = resumeItems[index];
    resumeItems[index] = resumeItems[index - 1];
    resumeItems[index - 1] = tmpData;
  }

  moveDown({required int index}) {
    Map tmpData = resumeItems[index];
    resumeItems[index] = resumeItems[index + 1];
    resumeItems[index + 1] = tmpData;
  }

  deleteResumeItem({required int index}) {
    resumeItems.removeAt(index);
  }
}
