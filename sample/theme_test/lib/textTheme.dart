import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        fontFamily: 'KoPubBatang',

        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Colors.black,
            fontSize: 40,
            fontWeight: FontWeight.w700,
            letterSpacing: 5,
          ),
        ),
      ),
      home: AppBarScreen(),
    );
  }
}

class AppBarScreen extends StatelessWidget {
  const AppBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Theme'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'displayLarge',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Text(
              'displayMedium',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              'displaySmall',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Text(
              'headlineLarge',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              'headlineMedium',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'headlineSmall',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            Text(
              'titleLarge',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              'titleMedium',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'titleSmall',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              'labelLarge',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            Text(
              'labelLarge',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              'labelLarge',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            Text(
              'bodyLarge',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'bodyMedium',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'bodySmall',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
