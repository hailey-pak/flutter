import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test/src/provider/count_provider.dart';
import 'package:provider_test/src/ui/count_home.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CountProvider _countProvider = Provider.of<CountProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Sample'),
      ),
      body: CountHomeWidget(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              _countProvider.add();
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              _countProvider.remove();
            },
            icon: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
