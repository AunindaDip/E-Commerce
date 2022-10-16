import 'package:flutter/cupertino.dart';
import "package:carousel_pro/carousel_pro.dart";

Widget imagecarasol = SizedBox(
  height: 200,
  child: Carousel(
    dotSize: 5.0,
    dotSpacing: 15.0,
    dotPosition: DotPosition.bottomCenter,
    autoplay: true,
    autoplayDuration:const Duration(milliseconds: 5000) ,

    images: [
      Image.asset('assets/images/SymbexIT.jpg', fit: BoxFit.fill),
      Image.asset('assets/images/cara1.jpg', fit: BoxFit.fill),
      Image.asset('assets/images/cara2.jpg', fit: BoxFit.fill),
      Image.asset('assets/images/cara3.jpg', fit: BoxFit.fill),
      Image.asset('assets/images/cara4.jpg', fit: BoxFit.fill),

    ],
  ),
);
