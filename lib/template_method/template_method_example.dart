import 'package:design_patterns/template_method/impl/student_json_bmi_calculator.dart';
import 'package:design_patterns/template_method/impl/student_xml_bmi_calculator.dart';
import 'package:design_patterns/template_method/impl/teenage_student_json_bmi_calculator.dart';
import 'package:design_patterns/template_method/student_section.dart';
import 'package:flutter/material.dart';

class TemplateMethodExample extends StatelessWidget {
  const TemplateMethodExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollBehavior(),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: LayoutConstants.paddingL,
            vertical: LayoutConstants.paddingL,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StudentsSection(
                bmiCalculator: StudentsXmlBmiCalculator(),
                headerText: 'Students from XML data source:',
              ),
              SizedBox(height: LayoutConstants.spaceL),
              StudentsSection(
                bmiCalculator: StudentsJsonBmiCalculator(),
                headerText: 'Students from JSON data source:',
              ),
              SizedBox(height: LayoutConstants.spaceL),
              StudentsSection(
                bmiCalculator: TeenageStudentsJsonBmiCalculator(),
                headerText: 'Students from JSON data source (teenagers only):',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LayoutConstants {
  static const double paddingL = 8;
  static const double spaceL = 20;
}
