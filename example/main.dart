import 'package:flutter/material.dart';

import 'package:mutable_icon/mutable_icon.dart';

void main() => runApp(const Example());

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  bool _submenu = false;
  late final MutableIconController _controller;

  @override
  void initState() {
    _controller = MutableIconController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MutableIcon Example',
      home: Scaffold(
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(
                Icons.wallet,
                color: Colors.black
              ),
              title: const Text('Wallet'),
              trailing: MutableIcon(
                duration: const Duration(milliseconds: 300),
                startIcon: Icons.expand_more,
                endIcon: Icons.expand_less,
                startIconColor: Colors.black,
                endIconColor: Colors.black,
                controller: _controller,
                initFrom: _submenu ? InitFrom.end : InitFrom.start
              ),
              onTap: () {
                setState(() {
                  _submenu = !_submenu;
                  if (_submenu) {
                    _controller.animateToEnd();
                  } else {
                    _controller.animateToStart();
                  }
                });
              },
            ),
            if (_submenu) ListTile(
              contentPadding: const EdgeInsets.only(left: 32),
              leading: const Icon(
                Icons.account_balance,
                color: Colors.black
              ),
              title: const Text('Balance'),
              onTap: () {},
            ),
          ],
        )
      ),
    );
  }
}
