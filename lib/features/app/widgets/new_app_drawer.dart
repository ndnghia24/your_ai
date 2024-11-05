import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = 20;
    final double verticalPadding = 10;

    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/yourai_logo.png', height: 40),
                    SizedBox(width: 8),
                    Text('Your AI', style: GoogleFonts.bebasNeue(fontSize: 35)),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
