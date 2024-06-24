import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerstudentrecorderhive/common/widget/app_appbar_widget.dart';
import 'package:providerstudentrecorderhive/common/widget/custom_snack_bar_widget.dart';
import 'package:providerstudentrecorderhive/common/widget/custom_text_widget.dart';
import 'package:providerstudentrecorderhive/common/widget/email_validation.dart';
import 'package:providerstudentrecorderhive/common/widget/save_button.dart';
import 'package:providerstudentrecorderhive/model/db_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:providerstudentrecorderhive/provider/home_controller.dart';

class AddStudentWidget extends StatefulWidget {
  const AddStudentWidget({super.key});

  @override
  State<AddStudentWidget> createState() => _AddStudentWidgetState();
}

class _AddStudentWidgetState extends State<AddStudentWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _domainController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  File? selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Add Student"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () async {
                    final returnedImage = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (returnedImage != null) {
                      setState(() {
                        selectedImage = File(returnedImage.path);
                      });
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      height: 150,
                      width: 150,
                      color: Colors.grey.withOpacity(0.5),
                      child: selectedImage == null
                          ? const Center(
                              child: Icon(Icons.add_a_photo),
                            )
                          : Image.file(
                              selectedImage!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormWidget(
                  labelText: "Name",
                  hintText: "Enter Student Name",
                  controller: _nameController,
                  validator: (value) => value == null || value.isEmpty
                      ? "Please Enter Your Name"
                      : null,
                ),
                const SizedBox(height: 15),
                CustomTextFormWidget(
                  labelText: "Domain",
                  hintText: "Enter Student Domain",
                  keyboardType: TextInputType.text,
                  controller: _domainController,
                  validator: (value) => value == null || value.isEmpty
                      ? "Please Enter Student Domain"
                      : null,
                ),
                const SizedBox(height: 15),
                CustomTextFormWidget(
                  labelText: "Email",
                  hintText: "Enter Student Email",
                  keyboardType: TextInputType.text,
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Student Email";
                    } else if (!isValidEmail(value)) {
                      return "Please Enter a Valid Email";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomTextFormWidget(
                  labelText: "Phone No",
                  hintText: "Enter Student Phone No:",
                  keyboardType: TextInputType.text,
                  controller: _phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Student Phone No";
                    } else if (!isValidPhoneNumber(value)) {
                      return "Enter a Valid Phone N0";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                SaveButton(onPressed: saveButton)
              ],
            )),
      ),
    );
  }

  saveButton() async {
    if (_formKey.currentState!.validate()) {
      final student = Student();
      student.name = _nameController.text;
      student.domain = _domainController.text;
      student.email = _emailController.text;
      student.phone = _phoneController.text;
      student.image = selectedImage!.path.toString();
      await Provider.of<StudentController>(context, listen: false)
          .addStudent(student);
      showSnackBar("${student.name} Added Succesfully", context);
      Navigator.pop(context);
    }
  }
}
