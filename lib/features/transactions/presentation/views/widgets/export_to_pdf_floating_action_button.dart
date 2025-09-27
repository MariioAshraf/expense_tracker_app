import 'package:flutter/material.dart';

import '../../../../../core/services/export_pdf_service.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../data/models/transaction_model.dart';
class ExportToPDFFloatingButton extends StatelessWidget {
  const ExportToPDFFloatingButton({
    super.key,
    required this.transactions,
  });

  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Export Transactions to PDF",
      child: FloatingActionButton(
        heroTag: "pdf_export",
        onPressed: () async {
          await TransactionsExportService.exportToPDF(transactions);
        },
        backgroundColor: AppColorsManager.mainBlue,
        child: const Icon(
          Icons.picture_as_pdf,
          color: Colors.white,
        ),
      ),
    );
  }
}