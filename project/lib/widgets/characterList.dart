import 'package:flutter/material.dart';
import 'package:project/objects/characters.dart' ;

class CharactersCardList extends StatelessWidget {
  final List<CharactersObject> items;

  CharactersCardList({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // Immagine a sinistra
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(items[index].imageUrl),
                      ),
                    ),
                  ),
                  SizedBox(width: 60.0),
                  // Testo a destra
                  Expanded(
                    child: Text(
                      items[index].text,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}