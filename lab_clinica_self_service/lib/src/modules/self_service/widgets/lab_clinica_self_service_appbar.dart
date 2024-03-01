import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:lab_clinica_core/lab_clinica_core.dart';

import '../self_service_controller.dart';

class LabClinicaSelfServiceAppbar extends LabClinicasAppBar {
  LabClinicaSelfServiceAppbar({super.key})
      : super(
          actions: [
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 1,
                    child: Text('Reiniciar processo.'),
                  )
                ];
              },
              onSelected: (value) async {
                Injector.get<SelfServiceController>().restartProcess();
              },
              child: const IconPopupMenuWidget(),
            )
          ],
        );
}
