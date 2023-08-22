import 'package:clone_voice/core/styles/custom_color_scheme.dart';
import 'package:clone_voice/core/styles/values.dart';
import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:metaballs/metaballs.dart';
import 'package:siri_wave/siri_wave.dart';

class GeneratingView extends StatefulWidget {
  const GeneratingView({super.key});

  @override
  State<GeneratingView> createState() => _GeneratingViewState();
}

class _GeneratingViewState extends State<GeneratingView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      appBar: AppBar(
        backgroundColor: themeData.colorScheme.background,
        title: const Text("Generating..."),
        elevation: 0,
        titleTextStyle: TextStyle(
            color: themeData.colorScheme.primaryTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w500),
        centerTitle: true,
        iconTheme: IconThemeData(color: themeData.colorScheme.primaryTextColor),
        automaticallyImplyLeading: false,
      ),
      body: Metaballs(
        effect: MetaballsEffect.follow(
          growthFactor: 0.5,
          smoothing: 1,
          radius: 1,
        ),
        gradient: const LinearGradient(colors: [
          Color.fromARGB(255, 90, 60, 255),
          Color.fromARGB(255, 120, 255, 255),
        ], begin: Alignment.bottomRight, end: Alignment.topLeft),
        metaballs: 27,
        animationDuration:
            const Duration(milliseconds: AppValues.generalDuration),
        speedMultiplier: 0.33,
        bounceStiffness: 3,
        minBallRadius: 1,
        maxBallRadius: 4,
        glowRadius: 0.7,
        glowIntensity: 0.33,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppValues.screenPadding * 2),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                SiriWave(
                    controller: SiriWaveController(
                      speed: 0.121,
                      amplitude: 0.72,
                      frequency: 20,
                      color: themeData.colorScheme.secondaryColor,
                    ),
                    style: SiriWaveStyle.ios_7,
                    options: const SiriWaveOptions(
                        showSupportBar: false, height: 260)),
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${_animation.value.toStringAsFixed(0)}%",
                              style: TextStyle(
                                color: themeData.colorScheme.secondaryColor,
                                fontSize: 36,
                              ),
                            ),
                            if (_animation.value == 100)
                              Container(
                                margin: const EdgeInsets.only(bottom: 5),
                                child: JumpingDots(
                                  color: themeData.colorScheme.secondaryColor,
                                  radius: 3,
                                  numberOfDots: 3,
                                  verticalOffset: 10,
                                  animationDuration:
                                      const Duration(milliseconds: 200),
                                ),
                              ),
                          ],
                        ),
                        Opacity(
                          opacity: _animation.value == 100 ? 1 : 0,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: themeData.colorScheme.secondaryColor
                                    .withOpacity(0.8),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const Spacer(),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
