import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hoopooh_app/modules/inBoarding/cubit/states.dart';

class InBoardingScreenCubit extends Cubit<InBoardingScreenStates>
{
  InBoardingScreenCubit() : super(InBoardingScreenInitialState());

  static InBoardingScreenCubit get (context) => BlocProvider.of(context);
  int currentPage = 0 ;
  void changePage(value)
  {
    currentPage = value ;
    emit(InBoardingScreenChangePageState());
  }

}