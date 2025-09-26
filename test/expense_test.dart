import 'package:expense_tracker_app/core/utils/expense_validator_for_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Expense Validation", () {
    test("Amount must be greater than 0", () {
      expect(ExpenseValidator.validateAmount(-5), "Amount must be greater than 0");
      expect(ExpenseValidator.validateAmount(0), "Amount must be greater than 0");
      expect(ExpenseValidator.validateAmount(100), null);
    });

    test("Currency must not be empty", () {
      expect(ExpenseValidator.validateCurrency(""), "Currency is required");
      expect(ExpenseValidator.validateCurrency("USD"), null);
    });

    test("Type must be income or expense", () {
      expect(ExpenseValidator.validateType("other"), "Type must be income or expense");
      expect(ExpenseValidator.validateType("income"), null);
      expect(ExpenseValidator.validateType("expense"), null);
    });
  });
}
