import 'package:expense_tracker/features/expense/domain/entity/expense.dart';
import 'package:expense_tracker/features/expense/presentation/widgets/expense_list.dart';
import 'package:expense_tracker/features/expense/presentation/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final List<Expense> _expenses = [
    Expense(
      icon: FontAwesomeIcons.trainSubway,
      title: 'Metro',
      amount: 1400.toDouble(),
      date: DateTime.now(),
      category: ExpenseCategory.transport,
    ),
    Expense(
      icon: FontAwesomeIcons.bagShopping,
      title: 'Coca Cola',
      amount: 12000.toDouble(),
      date: DateTime.now(),
      category: ExpenseCategory.food,
    ),
    Expense(
      icon: FontAwesomeIcons.internetExplorer,
      title: 'Internet bill',
      amount: 99000.toDouble(),
      date: DateTime.now(),
      category: ExpenseCategory.internet,
    ),
    Expense(
      icon: FontAwesomeIcons.phone,
      title: 'Cell Phone bill',
      amount: 12000.toDouble(),
      date: DateTime.now(),
      category: ExpenseCategory.cellPhone,
    ),
    Expense(
      icon: FontAwesomeIcons.bowlFood,
      title: 'Dinner',
      amount: 20000.toDouble(),
      date: DateTime.now(),
      category: ExpenseCategory.food,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return const NewExpense();
      },
    );
  }

  @override
  Widget build(BuildContext contexts) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: ExpenseList(expenses: _expenses),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddExpenseOverlay,
        child: const Icon(Icons.add),
      ),
    );
  }
}
