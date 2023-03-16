import 'package:flutter/material.dart';
import 'package:riverpod_theory/screen/home_scree.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
     child: MaterialApp(
       debugShowCheckedModeBanner: false,
       home: HomeScreen(),
     ),
    ),
  );
}

