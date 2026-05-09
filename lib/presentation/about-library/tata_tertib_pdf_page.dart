import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TataTertibPdfPage extends StatelessWidget {
  final String url;
  const TataTertibPdfPage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tata Tertib Perpustakaan")),
      body: SfPdfViewer.network(url),
    );
  }
}
