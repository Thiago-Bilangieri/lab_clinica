// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lab_clinica_core/lab_clinica_core.dart';

class DocumentsBoxWidget extends StatelessWidget {
  final bool uploaded;
  final Widget icon;
  final String label;
  final VoidCallback? onTap;
  final int totalFiles;
  const DocumentsBoxWidget({
    super.key,
    required this.uploaded,
    required this.icon,
    required this.label,
    this.onTap,
    required this.totalFiles,
  });

  @override
  Widget build(BuildContext context) {
    final totalFileLabel = totalFiles > 0 ? ' ($totalFiles)' : "";
    return Expanded(
      child: InkWell(
        onTap: onTap, 
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: uploaded ? LabClinicaTheme.lightOrangeColor : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: LabClinicaTheme.orangeColor),
          ),
          child: Column(
            children: [
              Expanded(child: icon),
              Text(
                '$label$totalFileLabel',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: LabClinicaTheme.orangeColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
