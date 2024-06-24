import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerstudentrecorderhive/common/widget/app_appbar_widget.dart';
import 'package:providerstudentrecorderhive/provider/home_controller.dart';

class ViewStudent extends StatelessWidget {
  final int studentId;
  const ViewStudent({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    final student =
        Provider.of<StudentController>(context).getStudentById(studentId);
    return Scaffold(
      appBar: CustomAppBar(title: student!.name),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 150,
                height: 150,
                color: Colors.grey.withOpacity(0.5),
                child: Image.file(
                  File(student.image),
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Icon(Icons.broken_image, size: 100);
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              student.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              student.domain,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              student.email,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              student.phone,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
