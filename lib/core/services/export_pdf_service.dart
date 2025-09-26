// import 'dart:io';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:share_plus/share_plus.dart';
// import 'package:path_provider/path_provider.dart';
// import '../../features/transactions/data/models/transaction_model.dart';
//
// class TransactionsExportService {
//   /// Export transactions to PDF file and share
//   static Future<void> exportToPDF(List<TransactionModel> transactions) async {
//     final pdf = pw.Document();
//
//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.Table.fromTextArray(
//             headers: ["Category", "Type", "Amount", "Currency", "Date"],
//             data: transactions.map((tx) {
//               return [
//                 tx.categoryName,
//                 tx.type.name,
//                 tx.amount.toString(),
//                 tx.currency,
//                 tx.date.toIso8601String(),
//               ];
//             }).toList(),
//           );
//         },
//       ),
//     );
//
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File("${dir.path}/transactions.pdf");
//
//     await file.writeAsBytes(await pdf.save());
//
//     await Share.shareXFiles(
//       [XFile(file.path)],
//       text: "Here is your Transactions PDF",
//     );
//   }
// }
