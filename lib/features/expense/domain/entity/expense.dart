// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:expense_tracker/features/expense/domain/entity/expense_category.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/features/expense/presentation/pages/new_expense.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Expense {
  final String id;

  final double amount;
  final Currency currency;
  final DateTime date;
  final ExpenseCategory category;

  Expense(
      {required double amount,
      required DateTime date,
      required ExpenseCategory category,
      required Currency currency})
      : this._(
            id: uuid.v4(),
            amount: amount,
            date: date,
            category: category,
            currency: currency);

  Expense._(
      {required this.id,
      required this.amount,
      required this.date,
      required this.category,
      required this.currency});

  Expense copyWith({
    String? id,
    String? title,
    double? amount,
    DateTime? date,
    ExpenseCategory? category,
  }) {
    return Expense(
        amount: amount ?? this.amount,
        date: date ?? this.date,
        category: category ?? this.category,
        currency: currency);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'date': date.millisecondsSinceEpoch,
      'category': category,
      'currency': currency.index
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    int val = map['category'];
    return Expense._(
      id: map['id'] as String,
      amount: map['amount'] as double,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      category: map['category'] as ExpenseCategory,
      currency: Currency.values[val],
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Expense(id: $id, amount: $amount, date: $date, category: $category, currency: $currency)';
  }

  @override
  bool operator ==(covariant Expense other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.currency == currency &&
        other.amount == amount &&
        other.date == date &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        currency.hashCode ^
        amount.hashCode ^
        date.hashCode ^
        category.hashCode;
  }
}
