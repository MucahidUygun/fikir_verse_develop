import 'dart:io';
import 'package:fikir_verse/core/model/kvkk_model.dart';
import 'package:fikir_verse/core/services/kvkk_services.dart';
import 'package:fikir_verse/core/widget/app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:fikir_verse/core/extension/context_extension.dart';

class ShowPdf extends StatefulWidget {
  const ShowPdf({Key? key}) : super(key: key);

  @override
  State<ShowPdf> createState() => _ShowPdfState();
}

class _ShowPdfState extends State<ShowPdf> {
  String? pdfFlePath;
  bool isLoading = true;

  Future<String> downloadAndSavePdf() async {
    KvkkModel model = await KvkkServices.getKvkk();
    final directory = await getApplicationDocumentsDirectory();
    String sampleUrl = model.kvkkContract.file;
    final file = File('${directory.path}/${model.kvkkContract.filename}');
    file;
    if (await file.exists()) {
      return file.path;
    }
    final response = await http.get(Uri.parse(sampleUrl));
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  void loadPdf() async {
    pdfFlePath = await downloadAndSavePdf();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size(context.width, context.heightNormalAppBar),
        child: const BuildAppBar(
          isShowPoint: false,
          title: 'Fikirverse | KVKK',
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            if (pdfFlePath != null)
              Expanded(
                child: isLoading
                ?const Center(child: CircularProgressIndicator())
                : PdfView(path: pdfFlePath!),
              )
            else
              const Text("KVKK Sözleşmesi Yüklenemedi!"),
          ],
        ),
      ),
    );
  }
}
