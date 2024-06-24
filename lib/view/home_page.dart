import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerstudentrecorderhive/common/colors.dart';
import 'package:providerstudentrecorderhive/common/widget/app_appbar_widget.dart';
import 'package:providerstudentrecorderhive/common/widget/delete_widget.dart';
import 'package:providerstudentrecorderhive/provider/home_controller.dart';
import 'package:providerstudentrecorderhive/view/add_student.dart';
import 'package:providerstudentrecorderhive/view/edit_student.dart';
import 'package:providerstudentrecorderhive/view/search_student.dart';
import 'package:providerstudentrecorderhive/view/view_student.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Student Recorder",
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const SearchStudent(),
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Consumer<StudentController>(
          builder: (context, studentController, child) {
        return studentController.students.isEmpty
            ? const Center(
                child: Text(
                  "No data, add One!",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 22),
                ),
              )
            : ListView.builder(
                itemCount: studentController.students.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.blueGrey[100],
                  elevation: 5,
                  child: ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => ViewStudent(
                            studentId: studentController.students[index].key))),
                    title: Text(
                      studentController.students[index].name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      studentController.students[index].domain,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: FileImage(
                          File(studentController.students[index].image)),
                    ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (ctx) => EditStudent(
                                      student:
                                          studentController.students[index]),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              delete(
                                  context,
                                  studentController.students[index].name,
                                  studentController.students[index].key);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red[600],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => const AddStudentWidget(),
            ),
          );
        },
        backgroundColor: AppColor.appBGColor,
        foregroundColor: AppColor.appFGColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
