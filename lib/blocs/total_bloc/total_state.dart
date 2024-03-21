part of 'total_bloc.dart';

class TotalSumState extends Equatable {
  final double total;

  const TotalSumState({required this.total});

  @override
  List<Object> get props => [total];
}
