import 'package:expense_tracker/features/expense/data/expense_provider.dart';
import 'package:expense_tracker/features/expense/presentation/widgets/expense_list.dart';
import 'package:expense_tracker/features/expense/presentation/pages/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpensesPage extends ConsumerStatefulWidget {
  const ExpensesPage({super.key});

  @override
  ConsumerState<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends ConsumerState<ExpensesPage> {
  @override
  Widget build(BuildContext contexts) {
    final expenses = ref.watch(expenseProvider);
    expenses.sort((a, b) => a.date.compareTo(b.date));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      body: ExpenseList(expenses: expenses),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NewExpense(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
