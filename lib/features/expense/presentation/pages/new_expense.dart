import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/features/expense/data/expense_provider.dart';
import 'package:expense_tracker/features/expense/domain/entity/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

enum Currency { USD, EUR, UZS }

class NewExpense extends ConsumerStatefulWidget {
  const NewExpense({
    super.key,
  });

  @override
  ConsumerState<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends ConsumerState<NewExpense> {
  final exchangeRate = 1 / 11400;
  late TextEditingController _amountController;
    double? _dollarAmount = 0.0;

  Currency _currency = Currency.UZS;
  ExpenseCategory _selectedCategory = expenseCategoryList[0];

  final _debouncer = Debouncer(milliseconds: 1000);

  DateTime? _selectedDate;

  void _presentDatePicker() {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    ).then(
      (date) {
        setState(
          () {
            _selectedDate = date;
          },
        );
      },
    );
  }

  void _submit() {
    final amount = double.tryParse(_amountController.text.trim());
    final date = _selectedDate;

    if (amount == null || date == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Please fill all the fields'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            )
          ],
        ),
      );
      return;
    }

    ref.read(expenseProvider.notifier).addExpense(
          Expense(
            icon: _selectedCategory.icon,
            amount: amount,
            date: _selectedDate!,
            category: _selectedCategory,
            currency: _currency,
          ),
        );
    Navigator.of(context).pop();
  }

  @override
  initState() {
    _amountController = TextEditingController();
    _amountController.addListener(
      () {
        _debouncer.run(
          () {
            debugPrint(
              _amountController.text,
            );
            setState(
              () {
                final amount = double.tryParse(_amountController.text.trim());
                amount != null
                    ? _dollarAmount = amount * exchangeRate
                    : _dollarAmount = null;
              },
            );
          },
        );
      },
    );
    super.initState();
  }

  @override
  dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Category: '),
                const SizedBox(
                  width: 10,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton<ExpenseCategory>(
                    value: _selectedCategory,
                    borderRadius: BorderRadius.circular(10),
                    items: expenseCategoryList
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                e.name.capitalize(),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(
                        () {
                          _selectedCategory = value;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: TextField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'(^\d*\.?\d*)'),
                        ),
                      ],
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 22),
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: 'Enter amount',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Currency>(
                      value: _currency,
                      borderRadius: BorderRadius.circular(10),
                      items: Currency.values
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  e.name,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(
                          () {
                            _currency = value;
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _dollarAmount != null
                      ? '\$${_dollarAmount?.toStringAsFixed(2)}'
                      : '',
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.calendar_month),
                  onPressed: _presentDatePicker,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Selected date: '),
                _selectedDate != null
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            formatter.format(_selectedDate!),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
