import 'dart:math';

import 'package:flutter/material.dart';
import 'package:winner/ui/screens/winners_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController winnersController = TextEditingController();
  Set<String> addressSet = <String>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 95, 204, 240),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Random Winner Picker',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: addressController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Enter Addresses (Space separated)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: winnersController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter Number of Winners',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                generateWinners(context);
              },
              child: const Text('Get Winners'),
            ),
          ],
        ),
      ),
    );
  }

  void generateWinners(BuildContext context) {
    String addresses = addressController.text;
    int numberOfWinners = int.tryParse(winnersController.text) ?? 0;

    if (numberOfWinners <= 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please enter a valid number of winners.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    addressSet = Set.from(addresses.split(' '));

    if (numberOfWinners > addressSet.length) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Number of winners exceeds the number of unique addresses.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    List<String> winners = [];

    for (int i = 0; i < numberOfWinners; i++) {
      if (addressSet.isEmpty) {
        break; // No more addresses to select from
      }

      String selectedWinner =
          addressSet.elementAt(Random().nextInt(addressSet.length));
      winners.add(selectedWinner);
      addressSet.remove(selectedWinner); // Remove the selected winner
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WinnersPage(winners),
      ),
    );
  }
}
