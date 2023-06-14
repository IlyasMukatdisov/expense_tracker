// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final expenseCategoryList = [
  ExpenseCategory(
    name: 'Transport',
    icCodePoint: FontAwesomeIcons.trainSubway.codePoint,
    icFontFamily: FontAwesomeIcons.trainSubway.fontFamily ?? '',
    icFontPackage: FontAwesomeIcons.trainSubway.fontPackage ?? '',
  ),
  ExpenseCategory(
    name: 'Food',
    icCodePoint: FontAwesomeIcons.bowlFood.codePoint,
    icFontFamily: FontAwesomeIcons.bowlFood.fontFamily ?? '',
    icFontPackage: FontAwesomeIcons.bowlFood.fontPackage ?? '',
  ),
  ExpenseCategory(
    name: 'Internet',
    icCodePoint: FontAwesomeIcons.internetExplorer.codePoint,
    icFontFamily: FontAwesomeIcons.internetExplorer.fontFamily ?? '',
    icFontPackage: FontAwesomeIcons.internetExplorer.fontPackage ?? '',
  ),
  ExpenseCategory(
    name: 'Cell Phone',
    icCodePoint: FontAwesomeIcons.phone.codePoint,
    icFontFamily: FontAwesomeIcons.phone.fontFamily ?? '',
    icFontPackage: FontAwesomeIcons.phone.fontPackage ?? '',
  ),
  ExpenseCategory(
    name: 'Shopping',
    icCodePoint: FontAwesomeIcons.bagShopping.codePoint,
    icFontFamily: FontAwesomeIcons.bagShopping.fontFamily ?? '',
    icFontPackage: FontAwesomeIcons.bagShopping.fontPackage ?? '',
  ),
  ExpenseCategory(
    name: 'Home',
    icCodePoint: FontAwesomeIcons.house.codePoint,
    icFontFamily: FontAwesomeIcons.house.fontFamily ?? '',
    icFontPackage: FontAwesomeIcons.house.fontPackage ?? '',
  )
];


class ExpenseCategory {
  final String name;
  final int icCodePoint;
  final String icFontFamily;
  final String icFontPackage;
  ExpenseCategory({
    required this.name,
    required this.icCodePoint,
    required this.icFontFamily,
    required this.icFontPackage,
  });

  ExpenseCategory copyWith({
    String? name,
    int? icCodePoint,
    String? icFontFamily,
    String? icFontPackage,
  }) {
    return ExpenseCategory(
      name: name ?? this.name,
      icCodePoint: icCodePoint ?? this.icCodePoint,
      icFontFamily: icFontFamily ?? this.icFontFamily,
      icFontPackage: icFontPackage ?? this.icFontPackage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'icCodePoint': icCodePoint,
      'icFontFamily': icFontFamily,
      'icFontPackage': icFontPackage,
    };
  }

  factory ExpenseCategory.fromMap(Map<String, dynamic> map) {
    return ExpenseCategory(
      name: map['name'] as String,
      icCodePoint: map['icCodePoint'] as int,
      icFontFamily: map['icFontFamily'] as String,
      icFontPackage: map['icFontPackage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ExpenseCategory.fromJson(String source) =>
      ExpenseCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ExpenseCategory(name: $name, icCodePoint: $icCodePoint, icFontFamily: $icFontFamily, icFontPackage: $icFontPackage)';
  }

  @override
  bool operator ==(covariant ExpenseCategory other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.icCodePoint == icCodePoint &&
        other.icFontFamily == icFontFamily &&
        other.icFontPackage == icFontPackage;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        icCodePoint.hashCode ^
        icFontFamily.hashCode ^
        icFontPackage.hashCode;
  }
}
