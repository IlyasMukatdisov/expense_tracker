import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/features/expense/domain/entity/expense.dart';
import 'package:expense_tracker/features/expense/domain/entity/expense_category.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;

  const ExpenseList({
    super.key,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        final category = expenseCategoryList.firstWhere((category) =>
            category.icCodePoint == expenses[index].category.icCodePoint);
        return ListTile(
          subtitle: Text(
            '${expenses[index].date.day}/${expenses[index].date.month}/${expenses[index].date.year}',
          ),
          title: Text(
            expenses[index].category.name.capitalize(),
          ),
          leading: Icon(
            IconData(
              category.icCodePoint,
              fontFamily: category.icFontFamily,
              fontPackage: category.icFontPackage,
            ),
          ),
          trailing: Column(
            children: [
              Text(
                '${expenses[index].amount.toString()} ${expenses[index].currency.name}',
              ),
            ],
          ),
        );
      },
    );
  }
}
