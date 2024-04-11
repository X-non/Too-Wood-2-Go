import 'package:flutter/material.dart';

class searchBar extends StatelessWidget {
  const searchBar({super.key});

  @override
  Widget build(BuildContext context){
    
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 40, left: 10, right: 10),
          height: 50,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                hintText: 'Sök',
                contentPadding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
        )
      ], 
    );

    ///TODO: det kommer behövas någon form av action när man trycker enter.
    //Vad händer när man sökt?
  } 
}