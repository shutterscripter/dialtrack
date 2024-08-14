import 'package:flutter/material.dart';

class ExportCallReport extends StatefulWidget {
  const ExportCallReport({Key? key}) : super(key: key);

  @override
  State<ExportCallReport> createState() => _ExportCallReportState();
}

class _ExportCallReportState extends State<ExportCallReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text('Export Call Report'),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              child: Text('Export Call Report'),
            ),
          ],
        ),
      ),
    );
  }
}
