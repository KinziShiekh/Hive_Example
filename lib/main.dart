import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/models/user_data.dart';
import 'data/repositories/user_data_repository_impl.dart';
import 'presentation/cubits/user_form_cubit.dart';
import 'presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  final box = await Hive.openBox('userDataBox');
  
  runApp(MyApp(box: box));
}

class MyApp extends StatelessWidget {
  final dynamic box;
  
  const MyApp({Key? key, required this.box}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserFormCubit>(
          create: (context) => UserFormCubit(UserDataRepositoryImpl(box)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hive Clean Architecture',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Color(0xFFF5F7FA),
          fontFamily: 'Roboto',
        ),
        home: HomeScreen(),
      ),
    );
  }
}
