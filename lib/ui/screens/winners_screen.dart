import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WinnersPage extends StatelessWidget {
  final List<String> winners;

  const WinnersPage(this.winners, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Randomly selected Winners'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Winners:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(winners.length,
                      (index) => buildWinnerTile(context, index)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: winners.join('\n')));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Addresses copied to clipboard'),
                  ),
                );
              },
              child: const Text('Copy All Addresses'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildWinnerTile(BuildContext context, int index) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${index + 1}. ${winners[index]}',
                textAlign: TextAlign.start,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: winners[index]));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Address copied to clipboard'),
                ),
              );
            },
            child: const Text('Copy'),
          ),
        ],
      ),
    );
  }
}
