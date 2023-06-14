import 'package:expense_tracker/features/expense/domain/entity/expense.dart';
import 'package:expense_tracker/features/expense/domain/entity/expense_category.dart';
import 'package:expense_tracker/features/expense/presentation/pages/new_expense.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ExpenseNotifier extends Notifier<List<Expense>> {
  @override
  List<Expense> build() {
    return [
      Expense(
        amount: 1400.toDouble(),
        currency: Currency.UZS,
        date: DateTime.now(),
        category: expenseCategoryList[0],
      ),
      Expense(
        currency: Currency.UZS,
        amount: 12000.toDouble(),
        date: DateTime.now(),
        category: expenseCategoryList[1],
      ),
      Expense(
        currency: Currency.UZS,
        amount: 99000.toDouble(),
        date: DateTime.now(),
        category: expenseCategoryList[2],
      ),
      Expense(
        currency: Currency.UZS,
        amount: 12000.toDouble(),
        date: DateTime.now(),
        category: expenseCategoryList[3],
      ),
      Expense(
        currency: Currency.UZS,
        amount: 20000.toDouble(),
        date: DateTime.now(),
        category: expenseCategoryList[1],
      ),
    ];
  }

  void addExpense(Expense expense) {
    state = [...state, expense];
  }
  // TODO add other methods, such as "removeTodo", ...
}

final expenseProvider = NotifierProvider<ExpenseNotifier, List<Expense>>(() {
  return ExpenseNotifier();
});
