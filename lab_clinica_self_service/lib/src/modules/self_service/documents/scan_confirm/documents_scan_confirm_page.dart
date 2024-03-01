import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:lab_clinica_self_service/src/modules/self_service/documents/scan_confirm/documents_scan_confirm_controller.dart';
import 'package:lab_clinica_self_service/src/modules/self_service/widgets/lab_clinica_self_service_appbar.dart';
import 'package:signals_flutter/signals_flutter.dart';

class DocumentsScanConfirmPage extends StatefulWidget {
  const DocumentsScanConfirmPage({super.key});

  @override
  State<DocumentsScanConfirmPage> createState() =>
      _DocumentsScanConfirmPageState();
}

class _DocumentsScanConfirmPageState extends State<DocumentsScanConfirmPage> {
  final controller = Injector.get<DocumentsScanConfirmController>();
  @override
  void initState() {
    effect(() {
      if (controller.pathRemoteStorage.value != null) {
        Navigator.of(context).pop();
        Navigator.of(context).pop(controller.pathRemoteStorage.value);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    final foto = ModalRoute.of(context)!.settings.arguments as XFile;
    //controller.pathRemoteStorage.listen(context, () {
      // Navigator.of(context).pop();
      //print("TESTE ${DateTime.now()}");
      //Navigator.of(context).pop(controller.pathRemoteStorage.value);
    //});
    return Scaffold(
      appBar: LabClinicaSelfServiceAppbar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            width: sizeOf.width * .85,
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: LabClinicaTheme.orangeColor),
            ),
            child: Column(
              children: [
                Image.asset('assets/images/foto_confirm_icon.png'),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'ADICIONAR DOCUMENTOS',
                  style: LabClinicaTheme.titleSmallStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    width: sizeOf.width * .5,
                    child: DottedBorder(
                      dashPattern: const [1, 10, 1, 3],
                      borderType: BorderType.RRect,
                      strokeWidth: 4,
                      radius: const Radius.circular(16),
                      strokeCap: StrokeCap.square,
                      color: LabClinicaTheme.orangeColor,
                      child: Image.file(
                        File(
                          foto.path,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton(
                          child: const Text('TIRAR OUTRA'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          child: const Text('SALVAR'),
                          onPressed: () async {
                            final imageBytes = await foto.readAsBytes();
                            final fileName = foto.name;
                            await controller.uploadImage(imageBytes, fileName);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
