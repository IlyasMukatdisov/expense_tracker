import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension JsonSerialization on IconData {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'codePoint': codePoint,
      'fontFamily': fontFamily,
      'fontPackage': fontPackage,
      'matchTextDirection': matchTextDirection,
    };
  }

  fromMap(Map<String, dynamic> map) {
    return IconData(
      map['codePoint'] as int,
      fontFamily:
          map['fontFamily'] != null ? map['fontFamily'] as String : null,
      fontPackage:
          map['fontPackage'] != null ? map['fontPackage'] as String : null,
      matchTextDirection: map['matchTextDirection'] as bool,
    );
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
