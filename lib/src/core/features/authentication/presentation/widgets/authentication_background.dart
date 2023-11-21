import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/image_strings.dart';

class AuthenticationBackground extends StatelessWidget {
  const AuthenticationBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(TImages.authBackground),
        Positioned(
          left: 30,
          width: 80,
          height: 200,
          child: FadeInDown(
            duration: const Duration(seconds: 1),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(TImages.light1),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 140,
          width: 80,
          height: 150,
          child: FadeInDown(
              duration: const Duration(milliseconds: 1200),
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage(TImages.light2))),
              )),
        ),
      ],
    );
  }
}
