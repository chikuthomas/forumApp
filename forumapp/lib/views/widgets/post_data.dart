import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:google_fonts/google_fonts.dart';

class post_data extends StatelessWidget {
  const post_data({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Super Admin",
            style: GoogleFonts.poppins(),
          ),
          Text("Admin@gmail.com",
              style: GoogleFonts.poppins(
                fontSize: 8,
              )),
          const SizedBox(
            height: 20,
          ),
          //making use of lorem ipsum package
          Text(
            lorem(paragraphs: 1, words: 30),
          ),
          Row(
            children: [
              IconButton(onPressed: () {},
                icon: Icon(Icons.thumb_up),
              ),
              IconButton(onPressed: () {},
                icon: Icon(Icons.message),
              ),
            ],
          )
        ],
      ),
    );
  }
}
