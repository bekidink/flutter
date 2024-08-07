import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:multivendor_app/constants/constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Padding(padding: EdgeInsets.only(bottom: 100),child: LottieBuilder.asset('assets/anime/loading.json',width: width,height: height,),),
    );
  }
}