import 'dart:typed_data';

import 'package:asyncstate/asyncstate.dart';
import 'package:lab_clinica_core/lab_clinica_core.dart';
import 'package:lab_clinica_self_service/src/repositories/documents/documents_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class DocumentsScanConfirmController with MessageStateMixin {
  DocumentsScanConfirmController({
    required this.documentsRepository,
  });

  final pathRemoteStorage = signal<String?>(null);

  final DocumentsRepository documentsRepository;
  Future<void> uploadImage(Uint8List imageBytes, String fileName) async {
    final result = await documentsRepository
        .uploadImage(imageBytes, fileName)
        .asyncLoader();

        switch(result){
          case Left<RepositoryException, String>():
            showError('Erro ao fazer upload da image');
          case Right<RepositoryException, String>(value: final pathFile):
            pathRemoteStorage.value = pathFile;
            
        }
  }
}
