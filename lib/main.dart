import 'package:flutter/material.dart';

import 'screens/Congratulations.dart';
import 'screens/alphabet_b_screen.dart';
import 'screens/alphabet_c_screen.dart';
import 'screens/alphabet_d_screen.dart';
import 'screens/alphabet_e_screen.dart';
import 'screens/alphabet_f_screen.dart';
import 'screens/alphabet_g_screen.dart';
import 'screens/alphabet_h_screen.dart';
import 'screens/alphabet_i_screen.dart';
import 'screens/alphabet_j_screen.dart';
import 'screens/alphabet_k_screen.dart';
import 'screens/alphabet_l_screen.dart';
import 'screens/alphabet_learning_screen.dart';
import 'screens/alphabet_m_screen.dart';
import 'screens/alphabet_n_screen.dart';
import 'screens/alphabet_o_screen.dart';
import 'screens/alphabet_p_screen.dart';
import 'screens/alphabet_q_screen.dart';
import 'screens/alphabet_r_screen.dart';
import 'screens/alphabet_s_screen.dart';
import 'screens/alphabet_t_screen.dart';
import 'screens/alphabet_u_screen.dart';
import 'screens/alphabet_v_screen.dart';
import 'screens/alphabet_w_screen.dart';
import 'screens/alphabet_x_screen.dart';
import 'screens/alphabet_y_screen.dart';
import 'screens/alphabet_z_screen.dart';
import 'screens/home_screen.dart';
import 'screens/number_1.dart';
import 'screens/number_2.dart';
import 'screens/number_3.dart';
import 'screens/number_4.dart';
import 'screens/number_5.dart';
import 'screens/second_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/welcome_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key); // Corrected initialization

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VocaBuddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/', 
      routes: {
        '/': (context) => WelcomeScreen(), 
        '/secondScreen': (context) => SecondScreen(),
        '/signin': (context) => SignUpScreen(), 
        '/home': (context) => HomeScreen(),
        '/congs': (context) => Congratulations(),
        '/1': (context) => NumberOneScreen(),
        '/2': (context) => NumberTwoScreen(),
        '/3': (context) => NumberThreeScreen(),
        '/4': (context) => NumberFourScreen(),
        '/5': (context) => NumberFiveScreen(),
        '/alphabet': (context) => AlphabetScreen(),
        '/b': (context) => AlphabetBScreen(),
        '/c': (context) => AlphabetCScreen(),
        '/d': (context) => AlphabetDScreen(),
        '/e': (context) => AlphabetEScreen(),
        '/f': (context) => AlphabetFScreen(),
        '/g': (context) => AlphabetGScreen(),
        '/h': (context) => AlphabetHScreen(),
        '/i': (context) => AlphabetIScreen(),
        '/j': (context) => AlphabetJScreen(),
        '/k': (context) => AlphabetKScreen(),
        '/l': (context) => AlphabetLScreen(),
        '/m': (context) => AlphabetMScreen(),
        '/n': (context) => AlphabetNScreen(),
        '/o': (context) => AlphabetOScreen(),
        '/p': (context) => AlphabetPScreen(),
        '/q': (context) => AlphabetQScreen(),
        '/r': (context) => AlphabetRScreen(),
        '/s': (context) => AlphabetSScreen(),
        '/t': (context) => AlphabetTScreen(),
        '/u': (context) => AlphabetUScreen(),
        '/v': (context) => AlphabetVScreen(),
        '/w': (context) => AlphabetWScreen(),
        '/x': (context) => AlphabetXScreen(),
        '/y': (context) => AlphabetYScreen(),
        '/z': (context) => AlphabetZScreen(),

      },
    );
  }
}
