import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/features/expense/domain/entity/expense.dart';
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
        return ListTile(
          title: Text(
            expenses[index].category.name.capitalize(),
          ),
          subtitle: Text(
            expenses[index].title.toString(),
          ),
          leading: Icon(
            expenses[index].icon,
          ),
        );
      },
    );
  }
}
