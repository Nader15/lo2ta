import 'package:equatable/equatable.dart';

class StoreEntity extends Equatable {
  final String id;
  final String name;
  final String logoUrl;
  final String address;
  final List<String> branches;
  final String workingHours;
  final double rating;

  const StoreEntity({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.address,
    required this.branches,
    required this.workingHours,
    required this.rating,
  });

  @override
  List<Object?> get props => [id, name, logoUrl, address, branches, workingHours, rating];
}
