// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:expense_tracker/core/utils/utils.dart';
import 'package:flutter/material.dart';

enum ExpenseCategory {
  food(0),
  transport(1),
  internet(2),
  cellPhone(3),
  shopping(4),
  house(5);

  const ExpenseCategory(this.value);
  final num value;
}

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;
  final IconData icon;
  Expense({
    required String title,
    required double amount,
    required DateTime date,
    required ExpenseCategory category,
    required IconData icon,
  }) : this._(
            id: uuid.v4(),
            title: title,
            amount: amount,
            date: date,
            category: category,
            icon: icon);

  Expense._({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.icon,
  });

  Expense copyWith({
    String? id,
    String? title,
    double? amount,
    DateTime? date,
    ExpenseCategory? category,
    IconData? icon,
  }) {
    return Expense(
      title: title ?? this.title,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      category: category ?? this.category,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.millisecondsSinceEpoch,
      'category': category.index,
      'icon': icon,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    int val = map['category'];
    return Expense._(
      id: map['id'] as String,
      title: map['title'] as String,
      amount: map['amount'] as double,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      category: ExpenseCategory.values[val],
      icon: map['icon'] as IconData,
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Expense(id: $id, title: $title, amount: $amount, date: $date, category: $category, icon: $icon)';
  }

  @override
  bool operator ==(covariant Expense other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.amount == amount &&
        other.date == date &&
        other.category == category &&
        other.icon == icon;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        amount.hashCode ^
        date.hashCode ^
        category.hashCode ^
        icon.hashCode;
  }
}
