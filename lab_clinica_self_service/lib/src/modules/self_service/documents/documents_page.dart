import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:lab_clinica_self_service/src/model/self_service_model.dart';
import 'package:lab_clinica_self_service/src/modules/self_service/documents/widgets/documents_box_widget.dart';
import 'package:lab_clinica_self_service/src/modules/self_service/patient/patient_controller.dart';
import 'package:lab_clinica_self_service/src/modules/self_service/self_service_controller.dart';
import 'package:lab_clinica_self_service/src/modules/self_service/widgets/lab_clinica_self_service_appbar.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> with MessagesViewMixin {
  final SelfServiceController selfServiceController =
      Injector.get<SelfServiceController>();

  @override
  void initState() {
    messageListener(selfServiceController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    final documents = selfServiceController.model.documents;
    final totalHealthInsuranceCard =
        documents?[DocumentsType.healthInsuranceCard]?.length ?? 0;
    final totalMedicalOrder =
        documents?[DocumentsType.medicalOrder]?.length ?? 0;
    return Scaffold(
      appBar: LabClinicaSelfServiceAppbar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
              width: sizeOf.width * .85,
              margin: const EdgeInsets.only(top: 18),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: LabClinicaTheme.orangeColor),
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/folder.png'),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    'ADICIONAR DOCUMENTOS',
                    style: LabClinicaTheme.titleSmallStyle,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  const Text(
                    'Selecione o documento que deseja fotografar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: LabClinicaTheme.blueColor,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: sizeOf.width * .8,
                    height: 241,
                    child: Row(
                      children: [
                        DocumentsBoxWidget(
                          onTap: () async {
                            final filePath = await Navigator.of(context)
                                .pushNamed('/self-service/documents-scan');
                            if (filePath != null && filePath != '') {
                              selfServiceController.registerDocument(
                                  DocumentsType.healthInsuranceCard,
                                  filePath.toString());
                              setState(() {});
                            }
                          },
                          uploaded: totalHealthInsuranceCard > 0,
                          icon: Image.asset(
                            'assets/images/id_card.png',
                          ),
                          label: 'CARTERINHA',
                          totalFiles: totalHealthInsuranceCard,
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                        DocumentsBoxWidget(
                          uploaded: totalMedicalOrder >0,
                          onTap: () async {
                            final filePath = await Navigator.of(context)
                                .pushNamed('/self-service/documents-scan');
                            if (filePath != null && filePath != '') {
                              selfServiceController.registerDocument(
                                  DocumentsType.medicalOrder,
                                  filePath.toString());
                              setState(() {});
                            }
                          },
                          icon: Image.asset(
                            'assets/images/document.png',
                          ),
                          label: "PEDIDO MÉDICO",
                          totalFiles: totalMedicalOrder,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Visibility(
                    visible: totalMedicalOrder > 0 && totalHealthInsuranceCard > 0,
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              selfServiceController.clearDocuments();
                              setState(() {
                                
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: const BorderSide(color: Colors.red),
                              fixedSize: const Size.fromHeight(48),
                            ),
                            child: const Text('REMOVER TODAS'),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/self-service/done');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: LabClinicaTheme.orangeColor,
                            fixedSize: const Size.fromHeight(48),
                          ),
                          child: const Text('FINALIZAR'),
                        )),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
