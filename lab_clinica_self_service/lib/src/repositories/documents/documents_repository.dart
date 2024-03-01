import 'dart:typed_data';

import 'package:lab_clinica_core/lab_clinica_core.dart';

abstract interface class DocumentsRepository {

Future<Either<RepositoryException, String>> uploadImage(Uint8List file, String path);
}