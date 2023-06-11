import 'dart:io';

import 'package:fetch_videos_api/core/core/app_theme.dart';
import 'package:fetch_videos_api/features/videos/presentation/blocs/video_player_cubit/video_player_cubit.dart';
import 'package:fetch_videos_api/features/videos/presentation/blocs/videos_bloc/videos_bloc.dart';
import 'package:fetch_videos_api/features/videos/presentation/screens/videos_list.dart';
import 'package:flutter/material.dart';
import 'injection_conrainer.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const VideosApp());
}

class VideosApp extends StatelessWidget {
  const VideosApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
          di.sl<VideosBloc>()
            ..add(GetAllVideosEvent()),
        ),
        BlocProvider(
          create: (context) => VideoPlayerCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: appTheme,
        home: const VideosListScreen(),
      ),
    );
  }
}
