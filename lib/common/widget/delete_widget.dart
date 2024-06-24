import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerstudentrecorderhive/common/widget/custom_snack_bar_widget.dart';
import 'package:providerstudentrecorderhive/provider/home_controller.dart';

delete(BuildContext context, String name, int id) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Delete Confirmation"),
      content: const Text("Are You Sure You want to delete this student?"),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cencel")),
        ElevatedButton(
            onPressed: () async {
              Provider.of<StudentController>(context, listen: false)
                  .deleteStudent(id);
              showSnackBar("$name Deleted Succesfully", context);
              Navigator.pop(context);
            },
            child: const Text("Confirm"))
      ],
    ),
  );
}
