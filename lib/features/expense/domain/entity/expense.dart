// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:expense_tracker/core/utils/utils.dart';
import 'package:expense_tracker/features/expense/presentation/pages/new_expense.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final expenseCategoryList = [
  ExpenseCategory(
    name: 'Transport',
    icon: FontAwesomeIcons.trainSubway,
  ),
  ExpenseCategory(
    name: 'Food',
    icon: FontAwesomeIcons.bowlFood,
  ),
  ExpenseCategory(
    name: 'Internet',
    icon: FontAwesomeIcons.internetExplorer,
  ),
  ExpenseCategory(
    name: 'Cell Phone',
    icon: FontAwesomeIcons.phone,
  ),
  ExpenseCategory(
    name: 'Shopping',
    icon: FontAwesomeIcons.bagShopping,
  ),
  ExpenseCategory(
    name: 'Home',
    icon: FontAwesomeIcons.house,
  )
];

class ExpenseCategory {
  final String name;
  final IconData icon;

  ExpenseCategory({
    required this.name,
    required this.icon,
  });

  ExpenseCategory copyWith({
    String? name,
    IconData? icon,
  }) {
    return ExpenseCategory(
      name: name ?? this.name,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'icon': icon.codePoint,
    };
  }

  factory ExpenseCategory.fromMap(Map<String, dynamic> map) {
    return ExpenseCategory(
      name: map['name'] as String,
      icon: IconData(map['icon'] as int, fontFamily: 'MaterialIcons'),
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseCategory.fromJson(String source) =>
      ExpenseCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ExpenseCategory(name: $name, icon: $icon)';

  @override
  bool operator ==(covariant ExpenseCategory other) {
    if (identical(this, other)) return true;

    return other.name == name && other.icon == icon;
  }

  @override
  int get hashCode => name.hashCode ^ icon.hashCode;
}

class Expense {
  final String id;

  final double amount;
  final Currency currency;
  final DateTime date;
  final ExpenseCategory category;
  final IconData icon;
  Expense(
      {required double amount,
      required DateTime date,
      required ExpenseCategory category,
      required IconData icon,
      required Currency currency})
      : this._(
            id: uuid.v4(),
            amount: amount,
            date: date,
            category: category,
            icon: icon,
            currency: currency);

  Expense._(
      {required this.id,
      required this.amount,
      required this.date,
      required this.category,
      required this.icon,
      required this.currency});

  Expense copyWith({
    String? id,
    String? title,
    double? amount,
    DateTime? date,
    ExpenseCategory? category,
    IconData? icon,
  }) {
    return Expense(
        amount: amount ?? this.amount,
        date: date ?? this.date,
        category: category ?? this.category,
        icon: icon ?? this.icon,
        currency: currency);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'date': date.millisecondsSinceEpoch,
      'category': category,
      'icon': icon,
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
      icon: map['icon'] as IconData,
      currency: Currency.values[val],
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Expense(id: $id, amount: $amount, date: $date, category: $category, icon: $icon, currency: $currency)';
  }

  @override
  bool operator ==(covariant Expense other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.currency == currency &&
        other.amount == amount &&
        other.date == date &&
        other.category == category &&
        other.icon == icon;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        currency.hashCode ^
        amount.hashCode ^
        date.hashCode ^
        category.hashCode ^
        icon.hashCode;
  }
}
