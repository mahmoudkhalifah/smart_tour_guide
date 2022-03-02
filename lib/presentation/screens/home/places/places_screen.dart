import 'package:app/presentation/widgets/place_card.dart';
import 'package:flutter/material.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({Key? key}) : super(key: key);

  @override
  _PlacesScreenState createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(20.0),
            child:PlaceCard(
              name: "Bey Citadel",
              description: 'Is a 15th-century defensive fortress located on the Mediterranean sea coast, '
                  'inssdf Alexandria, Egypt Is a 15th-century defensive fortress located on the '
                  'Mediterranean sea coast, in Alexandria, Egypt.Is a 15th-century defensive fortress'
                  ' located on the Mediterranean sea coast, in Alexandria, Egypt.Is a 15th-century defensive fortress located on the Mediterranean sea coast, in Alexandria, Egypt.',
              onPressed: () {},
              photoURL: 'https://www.blog.motifphotos.com/wp-content/uploads/2021/05/panorama-photo-02-1024x248.jpg',
            )
        ),
      ],
    );
  }
}
