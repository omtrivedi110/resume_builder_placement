import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resume_builder_placement/utils/route_utils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(MyRoutes.addResume);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Resume Home"),
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
