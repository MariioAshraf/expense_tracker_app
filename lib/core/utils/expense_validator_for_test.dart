class ExpenseValidator {
  static String? validateAmount(double amount) {
    if (amount <= 0) {
      return "Amount must be greater than 0";
    }
    return null;
  }

  static String? validateCurrency(String currency) {
    if (currency.isEmpty) {
      return "Currency is required";
    }
    return null;
  }

  static String? validateType(String type) {
    if (type != "income" && type != "expense") {
      return "Type must be income or expense";
    }
    return null;
  }
}
