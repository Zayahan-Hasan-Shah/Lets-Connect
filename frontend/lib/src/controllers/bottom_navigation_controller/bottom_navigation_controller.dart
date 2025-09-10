import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavigationController extends StateNotifier<int> {
  BottomNavigationController() : super(0);

  void setIndex(int index) {
    state = index;
  }
}


// provider

final bottomNavigationProvider =
    StateNotifierProvider<BottomNavigationController, int>((ref) {
  return BottomNavigationController();
});