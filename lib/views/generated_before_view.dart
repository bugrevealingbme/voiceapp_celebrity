import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:clone_voice/core/styles/custom_color_scheme.dart';
import 'package:clone_voice/view_model/generated_before_view_model/generated_before_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../core/base_view.dart';
import '../core/styles/values.dart';
import '../main_appbar.dart';

class GeneratedBeforeView extends StatelessWidget {
  const GeneratedBeforeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<GeneratedBeforeViewModel>(
      viewModel: GeneratedBeforeViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onDispose: (model) => model.dispose(),
      onPageBuilder: (context, viewModel, themeData) => Scaffold(
        backgroundColor: themeData.colorScheme.background,
        appBar: mainAppbar(themeData, context, title: 'Last Generated'),
        body: Observer(builder: (context) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(height: 30),
            shrinkWrap: true,
            itemCount: viewModel.generatedBefore?.length ?? 0,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.only(
              left: AppValues.screenPadding,
              right: AppValues.screenPadding,
              top: 20,
              bottom: kBottomNavigationBarHeight + 20,
            ),
            itemBuilder: (context, index) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              image: viewModel.generatedBefore?[index].voice
                                              ?.img !=
                                          null &&
                                      viewModel.generatedBefore?[index].voice
                                              ?.img !=
                                          ""
                                  ? DecorationImage(
                                      colorFilter: ColorFilter.mode(
                                          Colors.black.withOpacity(0.9721),
                                          BlendMode.dstATop),
                                      alignment: Alignment.center,
                                      image: CachedNetworkImageProvider(
                                        viewModel.generatedBefore?[index].voice
                                                ?.img ??
                                            '',
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: themeData.colorScheme.secondaryBgColor,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              viewModel.generatedBefore?[index].text ?? '',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (viewModel.generatedBefore![index].url != null &&
                      viewModel.generatedBefore![index].url != '')
                    Builder(builder: (_) {
                      bool play = false;

                      return StatefulBuilder(builder: (context, setstate) {
                        return AudioWidget.network(
                          url: viewModel.generatedBefore![index].url ?? '',
                          play: play,
                          loopMode: LoopMode.none,
                          initialPosition: Duration.zero,
                          onFinished: () => play = false,
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: InkWell(
                              onTap: () {
                                HapticFeedback.lightImpact();

                                setstate(
                                  () {
                                    play = !play;
                                  },
                                );

                                return;
                              },
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Icon(
                                play == true ? Icons.stop : Icons.play_arrow,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        );
                      });
                    })
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
