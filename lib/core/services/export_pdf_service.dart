import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/transactions/data/models/transaction_model.dart';

class TransactionsExportService {
  static Future<void> exportToPDF(List<TransactionModel> transactions) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Transactions Report',
                style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: ["Category", "Type", "Amount", "Currency", "Date"],
                data: transactions.map((tx) {
                  return [
                    tx.categoryName ?? '',
                    tx.type.name ?? '',
                    tx.amount.toString(),
                    tx.currency ?? '',
                    tx.date.toString().substring(0, 10),
                  ];
                }).toList(),
                border: pw.TableBorder.all(),
                // headerDecoration: pw.BoxDecoration(
                //   color: pw.PdfColor.fromHex('#E0E0E0'), // رمادي فاتح
                // ),
                cellPadding: pw.EdgeInsets.all(5),
              ),
            ],
          );
        },
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/transactions_${DateTime.now().millisecondsSinceEpoch}.pdf");

    await file.writeAsBytes(await pdf.save());

    await Share.shareXFiles(
      [XFile(file.path)],
      text: "تقرير المعاملات المالية",
    );
  }
}