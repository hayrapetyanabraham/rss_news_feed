import 'package:flutter/material.dart';
import 'package:flutter_duration_picker/flutter_duration_picker.dart';
import 'package:newsfeed/constants/app_colors.dart';
import 'package:newsfeed/helpers/preferences_helper.dart';
import 'package:newsfeed/mixins/scaffold_mixin.dart';
import 'package:newsfeed/widget/shadow_container.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with ScaffoldMixin {
  int duration;
  bool initLoading = true;

  @override
  void initState() {
    super.initState();
    initDuration();
  }

  Future<void> initDuration() async {
    initLoading = true;
    duration = await StorageHelper.getSelectedDuration();
    initLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return initLoading
        ? Container(
            alignment: Alignment.center,
            height: 48,
            width: 48,
            child: const CircularProgressIndicator(),
          )
        : Scaffold(
            key: scaffoldKey,
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                InkWell(
                  onTap: showDurationSelectorPage,
                  child: ShadowContainer(
                    height: 96,
                    blurRadius: 20,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    shadowColor: const Color.fromRGBO(188, 201, 215, 0.25),
                    child: Row(
                      children: <Widget>[
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Duration time',
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: navyColor),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Click for chane',
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w600,
                                    color: navyColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox.fromSize(
                          child: ClipOval(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.timer),
                                // icon
                                Text(duration == null
                                    ? '15'
                                    : duration.toString()),
                                // text
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Minimum duration should be 15 minutes',
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w400,
                      color: navyColor),
                ),
              ],
            ));
  }

  Future<void> showDurationSelectorPage() async {
    Duration resultingDuration = await showDurationPicker(
      context: context,
      initialTime: new Duration(minutes: duration == null ? 15 : duration),
    );
    if (resultingDuration.inMinutes < 15) {
      showSnackBar(scaffoldKey,
          text: 'Minimum value should be 15 Min', color: deletedColor);
    } else {
      StorageHelper.setSelectedDuration(resultingDuration.inMinutes);
      duration = resultingDuration.inMinutes;
      setState(() {});
    }
  }
}
