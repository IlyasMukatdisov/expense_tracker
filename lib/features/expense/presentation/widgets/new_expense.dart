import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/features/expense/domain/entity/expense.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final exchangeRate = 1 / 11400;
  late TextEditingController _amountController;
  ExpenseCategory? category;
  double? dollarAmount = 0.0;

  final _debouncer = Debouncer(milliseconds: 1000);
  DateTime? selectedDate;

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
            selectedDate = date;
          },
        );
      },
    );
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
                    ? dollarAmount = amount * exchangeRate
                    : dollarAmount = null;
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

  void _openAddCategoryOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return const Text('Test');
      },
    );
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
                CircleAvatar(
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _openAddCategoryOverlay,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(category == null ? 'Add Category' : ''),
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: TextField(
                      textAlign: TextAlign.end,
                      style: const TextStyle(fontSize: 22),
                      controller: _amountController,
                      keyboardType: const TextInputType.numberWithOptions(),
                      decoration: const InputDecoration(
                        isDense: true,
                        hintText: '0',
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
                    child: DropdownButton(
                      borderRadius: BorderRadius.circular(10),
                      items: const [
                        DropdownMenuItem(
                          child: Text('UZS'),
                        ),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  dollarAmount != null
                      ? '\$${dollarAmount?.toStringAsFixed(2)}'
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
                selectedDate != null
                    ? Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Text(
                            formatter.format(selectedDate!),
                            textAlign: TextAlign.end,
                          ),
                        ),
                      )
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
