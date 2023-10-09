import 'package:flutter/material.dart';
import 'package:nmg_assignment/cubit/posts_cubit.dart';
import 'package:nmg_assignment/ui/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nmg_assignment/repository/post_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final PostRepository postRepository=PostRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> PostsCubit(postRepository)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
