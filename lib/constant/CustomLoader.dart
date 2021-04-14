import 'package:flutter/material.dart';
import 'package:service_provider_app/constant/constants.dart';

const TWO_PI = 3.14 * 2;

class CustomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size/2;

    return SafeArea(
      child: Scaffold(
        body: Center(
          // This Tween Animation Builder is Just For Demonstration, Do not use this AS-IS in Projects
          // Create and Animation Controller and Control the animation that way.
          child: TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(seconds: 3),
            builder: (context, value, child) {
              int percentage = (value * 100).ceil();
              return Container(
                width: size.width,
                height: size.height,
                child: Stack(
                  children: [
                    ShaderMask(
                      shaderCallback: (rect) {
                        return SweepGradient(
                            startAngle: 0.0,
                            endAngle: TWO_PI,
                            stops: [value, value],
                            // 0.0 , 0.5 , 0.5 , 1.0
                            center: Alignment.center,
                            colors: [
                              mainBackGround,
                              Colors.grey.withAlpha(55)
                            ]).createShader(rect);
                      },
                      child: Container(
                        width: size.width,
                        height: size.height,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: mainBackGround
                            // image: DecorationImage(image: Image.asset("assets/images/radial_scale.png").image)
                            ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: size.width - 40,
                        height: size.height - 40,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Center(
                            child: Text(
                          "$percentage",
                          style: TextStyle(fontSize: 40),
                        )),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
