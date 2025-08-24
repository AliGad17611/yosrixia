import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yosrixia/features/child/games/identical_character/cubits/tutorial_cubit/identical_character_tutorial_state.dart';

class IdenticalCharacterTutorialCubit
    extends Cubit<IdenticalCharacterTutorialState> {
  IdenticalCharacterTutorialCubit()
      : super(IdenticalCharacterTutorialInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void checkTutorialStatus() async {
    final user = _auth.currentUser;
    if (user == null) {
      emit(IdenticalCharacterTutorialNotSeen());
    } else {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data() as Map<String, dynamic>;
        final hasSeenTutorial =
            userData['hasSeenIdenticalCharacterTutorial'] ?? false;
        if (hasSeenTutorial) {
          emit(IdenticalCharacterTutorialSeen());
        } else {
          emit(IdenticalCharacterTutorialNotSeen());
        }
      }
    }
  }

  void markTutorialAsSeen() async {
    final user = _auth.currentUser;
    if (user == null) {
      return;
    }
    emit(IdenticalCharacterTutorialSeen());
    await _firestore.collection('users').doc(user.uid).update({
      'hasSeenIdenticalCharacterTutorial': true,
    });
  }
}
