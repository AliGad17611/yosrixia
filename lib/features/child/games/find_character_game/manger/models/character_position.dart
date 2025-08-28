import 'package:equatable/equatable.dart';

class CharacterPosition extends Equatable {
  final int id;
  final double left;
  final double top;
  final bool isVisible;

  const CharacterPosition({
    required this.id,
    required this.left,
    required this.top,
    required this.isVisible,
  });

  @override
  List<Object> get props => [id, left, top, isVisible];

  CharacterPosition copyWith({
    int? id,
    double? left,
    double? top,
    bool? isVisible,
  }) {
    return CharacterPosition(
      id: id ?? this.id,
      left: left ?? this.left,
      top: top ?? this.top,
      isVisible: isVisible ?? this.isVisible,
    );
  }
}
