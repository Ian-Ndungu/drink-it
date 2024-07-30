import 'package:flutter/material.dart';
import 'package:drinkit/widgets/small_text.dart';

class DrinkCard extends StatelessWidget {
  final String image_url;
  final String name;
  final VoidCallback onTap;

  const DrinkCard({
    Key? key,
    required this.image_url, 
    required this.name,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        margin: EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image_url), 
                    fit: BoxFit.cover,
                  ),
                  borderRadius:const BorderRadius.vertical(top: Radius.circular(20)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SmallText(
                text: name, 
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
