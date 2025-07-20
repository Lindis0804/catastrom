import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/common/widgets/custom_button.dart';
import 'package:template/pages/settings/bloc/settings.bloc.dart';
import 'package:template/root/app_routers.dart';

class SettingsBlocBuilder extends StatefulWidget {
  final SettingsBloc settingsBloc;
  const SettingsBlocBuilder({super.key, required this.settingsBloc});

  @override
  State<SettingsBlocBuilder> createState() => _SettingsBlocBuilderState();
}

class _SettingsBlocBuilderState extends State<SettingsBlocBuilder> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
              child: Column(
            children: [
              BigCustomButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRouters.login);
                    SharedPreferencesManager.removeToken(SPKeys.ACCESS_TOKEN);
                  },
                  text: 'Log out')
            ],
          )),
        );
      },
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider<SettingsBloc>(
        create: (_) => SettingsBloc(),
        child: BlocListener<SettingsBloc, SettingsState>(
          listener: _listener,
          child: Builder(
            builder: (BuildContext context) => SettingsBlocBuilder(
              settingsBloc: context.read<SettingsBloc>(),
            ),
          ),
        ),
      );
}

void _listener(BuildContext context, SettingsState state) {}
