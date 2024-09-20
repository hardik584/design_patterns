import 'package:design_patterns/template_method/model/student.dart';
import 'package:design_patterns/template_method/template/student_bmi_calculator.dart';
import 'package:flutter/material.dart';

class StudentsSection extends StatefulWidget {
  final StudentsBmiCalculator bmiCalculator;
  final String headerText;

  const StudentsSection({
    super.key,
    required this.bmiCalculator,
    required this.headerText,
  });

  @override
  State<StudentsSection> createState() => _StudentsSectionState();
}

class _StudentsSectionState extends State<StudentsSection> {
  final List<Student> students = [];

  void _calculateBmiAndGetStudentsData() {
    students.addAll(widget.bmiCalculator.calculateBmiAndReturnStudentList());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return students.isEmpty
        ? ElevatedButton(
            onPressed: () {
              _calculateBmiAndGetStudentsData();
            },
            child: Text(widget.headerText))
        : Column(
            children: [
              Text(
                widget.headerText,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Student student = students[index];
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(student.bmi.toStringAsFixed(0)),
                    ),
                    title: Text(student.fullName),
                    subtitle: Text(
                        "Age: ${student.age.toString()} || Height: ${student.height} || Weight: ${student.weight}"),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    height: 1,
                  );
                },
                itemCount: students.length,
              ),
            ],
          );
  }
}
