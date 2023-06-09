import 'package:expense_tracker/features/expense/domain/entity/expense.dart';
import 'package:expense_tracker/features/expense/presentation/pages/new_expense.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpenseNotifier extends Notifier<List<Expense>> {
  @override
  List<Expense> build() {
    return [
      Expense(
        icon: FontAwesomeIcons.trainSubway,
        amount: 1400.toDouble(),
        currency: Currency.UZS,
        date: DateTime.now(),
        category: expenseCategoryList[0],
      ),
      Expense(
        icon: FontAwesomeIcons.bagShopping,
        currency: Currency.UZS,
        amount: 12000.toDouble(),
        date: DateTime.now(),
        category: expenseCategoryList[1],
      ),
      Expense(
        icon: FontAwesomeIcons.internetExplorer,
        currency: Currency.UZS,
        amount: 99000.toDouble(),
        date: DateTime.now(),
        category: expenseCategoryList[2],
      ),
      Expense(
        icon: FontAwesomeIcons.phone,
        currency: Currency.UZS,
        amount: 12000.toDouble(),
        date: DateTime.now(),
        category: expenseCategoryList[3],
      ),
      Expense(
        icon: FontAwesomeIcons.bowlFood,
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
