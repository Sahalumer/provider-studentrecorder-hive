import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerstudentrecorderhive/provider/home_controller.dart';

class SearchStudent extends StatelessWidget {
  const SearchStudent({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: Consumer<StudentController>(
          builder: (context, studentController, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) => studentController.search(value),
                    decoration: InputDecoration(
                      hintText: "Search...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: studentController.results.isEmpty
                      ? const Center(
                          child: Text("No Student Found"),
                        )
                      : ListView.builder(
                          itemCount: studentController.results.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: ListTile(
                                title:
                                    Text(studentController.results[index].name),
                              ),
                            );
                          },
                        ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
