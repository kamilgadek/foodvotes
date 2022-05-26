import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddOpinionPageContent extends StatefulWidget {
  const AddOpinionPageContent({
    Key? key,
    required this.onSave,
  }) : super(key: key);
  final Function onSave;

  @override
  State<AddOpinionPageContent> createState() => _AddOpinionPageContentState();
}

var rating = 3.0;
var restaurantName = '';
var pizzaName = '';

class _AddOpinionPageContentState extends State<AddOpinionPageContent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration:
                  const InputDecoration(hintText: 'Podaj nazwe restauracji'),
              onChanged: (newValue) {
                setState(() {
                  restaurantName = newValue;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Podaj nazwe pizzy'),
              onChanged: (newValue) {
                setState(() {
                  pizzaName = newValue;
                });
              },
            ),
            Slider(
              onChanged: (newValue) {
                setState(() {
                  rating = newValue;
                });
              },
              value: rating,
              min: 1.0,
              max: 6.0,
              divisions: 10,
              label: rating.toString(),
            ),
            ElevatedButton(
                onPressed: restaurantName.isEmpty || pizzaName.isEmpty
                    ? null
                    : () {
                        FirebaseFirestore.instance
                            .collection('restaurants')
                            .add({
                          'name': restaurantName,
                          'pizza': pizzaName,
                          'rating': rating,
                        });
                        widget.onSave();
                      },
                child: const Text('Dodaj'))
          ],
        ),
      ),
    );
  }
}
