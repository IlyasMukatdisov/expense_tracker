import 'dart:async';

import 'package:expense_tracker/core/utils/utils.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {

  late TextEditingController _titleController;
  
  final _debouncer = Debouncer(milliseconds: 1000);

  @override
  initState() {
    _titleController = TextEditingController();
    _titleController.addListener(
      () {
        _debouncer.run(
          () {
            debugPrint(
              _titleController.text,
            );
          },
        );
      },
    );
    super.initState();
  }

  @override
  dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
