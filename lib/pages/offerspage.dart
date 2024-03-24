import 'package:flutter/material.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Offer(
          title: "Best offer ever!",
          description: "Buy one get one free",
        ),
        Offer(
          title: "Best offer ever!",
          description: "Buy one get one free",
        ),
        Offer(
          title: "Best offer ever!",
          description: "Buy one get one free",
        ),
        Offer(
          title: "Best offer ever!",
          description: "Buy one get one free",
        ),
        Offer(
          title: "Best offer ever!",
          description: "Buy one get one free",
        ),
        Offer(
          title: "Best offer ever!",
          description: "Buy one get one free",
        ),
      ],
    );
  }
}

class Offer extends StatelessWidget {
  //properties
  final String title;
  final String description;

  const Offer({super.key, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Card(
        elevation: 7,
        color: Colors.amber.shade50,
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              'images/background.png',
            ),
          )),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Container(
                  color: Colors.amber.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Container(
                  color: Colors.amber.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      description,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
