import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedCard {
  final String id;
  final String nameOnCard;
  final String cardNumber;
  final String expiryDate;
  final String cvc;
  final String country;
  final bool isDefault;

  SavedCard({
    required this.id,
    required this.nameOnCard,
    required this.cardNumber,
    required this.expiryDate,
    required this.cvc,
    required this.country,
    this.isDefault = false,
  });

  String get lastFour {
    final clean = cardNumber.replaceAll(' ', '');
    return clean.length >= 4 ? clean.substring(clean.length - 4) : clean;
  }

  SavedCard copyWith({
    String? id,
    String? nameOnCard,
    String? cardNumber,
    String? expiryDate,
    String? cvc,
    String? country,
    bool? isDefault,
  }) {
    return SavedCard(
      id: id ?? this.id,
      nameOnCard: nameOnCard ?? this.nameOnCard,
      cardNumber: cardNumber ?? this.cardNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      cvc: cvc ?? this.cvc,
      country: country ?? this.country,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

class SavedCardsNotifier extends StateNotifier<List<SavedCard>> {
  SavedCardsNotifier() : super([
    // Add an initial pre-filled card matching the default values from payments screen
    SavedCard(
      id: '1',
      nameOnCard: 'Zrent Zion',
      cardNumber: '1234 9087 9992 3655',
      expiryDate: '02/2021',
      cvc: '999',
      country: 'Nigeria',
      isDefault: true,
    ),
  ]);

  void addCard(SavedCard card) {
    if (card.isDefault || state.isEmpty) {
      // Unset previous defaults
      state = [
        for (final c in state) c.copyWith(isDefault: false),
        card.copyWith(isDefault: true),
      ];
    } else {
      state = [...state, card];
    }
  }

  void removeCard(String id) {
    state = state.where((c) => c.id != id).toList();
    // If we removed the default card and there are other cards left, make the first one default
    if (state.isNotEmpty && !state.any((c) => c.isDefault)) {
      state = [
        state.first.copyWith(isDefault: true),
        ...state.sublist(1),
      ];
    }
  }

  void setDefault(String id) {
    state = [
      for (final c in state)
        c.copyWith(isDefault: c.id == id),
    ];
  }
}

final savedCardsProvider = StateNotifierProvider<SavedCardsNotifier, List<SavedCard>>((ref) {
  return SavedCardsNotifier();
});
