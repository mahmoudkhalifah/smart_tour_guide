import 'package:app/data/models/statue.dart';
import 'package:app/data/repository/statues_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:meta/meta.dart';

part 'statues_state.dart';

class StatuesCubit extends Cubit<StatuesState> {
  StatuesCubit(this.statuesRepository) : super(StatuesInitial());

  final StatuesRepository statuesRepository;

  void resetToInitial() {
    emit(StatuesInitial());
  }

  void getStatues(int placeId) {
    statuesRepository.getStatues(placeId).then((statues) {
      if(statues.isNotEmpty) {
        emit(StatuesLoaded(statues));
      } else {
        emit(StatuesError());
      }
    });
  }

  void getStatueInfoByPhoto(XFile image, int placeId) async {
    emit(StatuePredictionLoading());
    statuesRepository
        .getStatueInfoByPhoto(image, placeId)
        .then((statue) {
          if (statue!=null) {
            emit(StatuePredicted(statue));
          } else {
            emit(StatueNotPredicted());
          }
        }
        );
  }

}
