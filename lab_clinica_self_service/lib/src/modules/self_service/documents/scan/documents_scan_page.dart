import 'package:asyncstate/asyncstate.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:lab_clinica_self_service/src/modules/self_service/patient/patient_controller.dart';
import 'package:lab_clinica_self_service/src/modules/self_service/widgets/lab_clinica_self_service_appbar.dart';
import 'package:dotted_border/dotted_border.dart';

class DocumentsScanPage extends StatefulWidget {
  const DocumentsScanPage({super.key});

  @override
  State<DocumentsScanPage> createState() => _DocumentsScanPageState();
}

class _DocumentsScanPageState extends State<DocumentsScanPage> {
  late CameraController cameraController;

  @override
  void initState() {
    cameraController = CameraController(
        Injector.get<List<CameraDescription>>().first,
        ResolutionPreset.ultraHigh);
    super.initState();
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
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
                Image.asset('assets/images/cam_icon.png'),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'CONFIRA SUA FOTO',
                  style: LabClinicaTheme.titleSmallStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 15,
                ),
                FutureBuilder(
                  future: cameraController.initialize(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.done:
                        if (cameraController.value.isInitialized) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: SizedBox(
                              width: sizeOf.width * .5,
                              child: CameraPreview(
                                cameraController,
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  strokeWidth: 4,
                                  radius: const Radius.circular(16),
                                  strokeCap: StrokeCap.square,
                                  color: LabClinicaTheme.orangeColor,
                                  dashPattern: const [1, 10, 1, 3],
                                  child: const SizedBox.expand(),
                                ),
                              ),
                            ),
                          );
                        }
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.none:
                    }
                    return const Center(
                      child: Text('Erro ao carregar a camera'),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: sizeOf.width * .8,
                  child: ElevatedButton(
                    child: const Text('TIRAR FOTO'),
                    onPressed: () async {
                      final nav = Navigator.of(context);
    
                      final foto =
                          await cameraController.takePicture().asyncLoader();
    
                      nav.pushNamed('/self-service/documents-scan-confirm',
                          arguments: foto);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
