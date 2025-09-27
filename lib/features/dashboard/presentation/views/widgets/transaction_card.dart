import 'package:expense_tracker_app/core/utils/format_date_time.dart';
import 'package:expense_tracker_app/features/transactions/domain/entities/filters.dart';
import 'package:flutter/material.dart';
import '../../../../transactions/data/models/transaction_model.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  final int index;

  const TransactionCard({
    super.key,
    required this.transaction,
    required this.index,
  });

  final List<Color> colors = const [
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.green,
    Colors.red,
    Colors.teal,
    Colors.brown,
    Colors.indigo,
    Colors.pink,
    Colors.cyan,
  ];

  @override
  Widget build(BuildContext context) {
    final color = colors[index % colors.length];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: color.withAlpha(50),
            child: Icon(
              IconData(transaction.categoryIcon, fontFamily: 'MaterialIcons'),
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.categoryName,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  "Manually",
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${transaction.type == TransactionTypeFilter.income ? '+' : '-'}  ${transaction.amount} ${transaction.currency}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                formatDateTime(transaction.date),
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
            ],
          )
        ],
      ),
    );
  }
}
