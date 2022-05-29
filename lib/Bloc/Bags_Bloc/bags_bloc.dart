import 'package:almajidoud/Helper/app_event.dart';
import 'package:almajidoud/Helper/app_state.dart';
import 'package:almajidoud/Repository/BagsRepo/bags_Repository.dart';
import 'package:almajidoud/utils/file_export.dart';

class BagsBloc extends Bloc<AppEvent,AppState>{

  BagsBloc():super(Start()){
    on<SendBagsNumberEvent>(_onSendBagsNumber);
  }

  Future<void> _onSendBagsNumber(SendBagsNumberEvent event , Emitter<AppState> emit)async{
    emit( Loading(indicator: 'SendBagsNumberEvent'));
    var response = await BagsRepository.send_bags_number(
        bags_number: event.bags_number,
        context: event.context
    ).then((value){
      if(value ==true){
        emit( Done(indicator: 'SendBagsNumberEvent'));
      }else{
        emit(  ErrorLoading(indicator: 'SendBagsNumberEvent'));
      }
    });

  }

}
final bags_bloc = BagsBloc();