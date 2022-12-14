import 'package:almajidoud/Model/StoreLocatorModel/store_locator_model.dart';
import 'package:almajidoud/Repository/StoreLocatorRepo/store_locatore_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';

class StoreLocatorBloc extends Bloc<AppEvent,AppState>{

  StoreLocatorBloc():super(Start()){
    on<GetAllStoreLocatoreEvent>(_onGetAllStoreLocatoreEvent);
  }

  BehaviorSubject<List<StoreLocatorModel>> _store_locator_subject = new BehaviorSubject<List<StoreLocatorModel>>();
  get store_locator_subject {
    return _store_locator_subject;
  }


  void drainStream() {
    _store_locator_subject.close();
  }

  Future<void> _onGetAllStoreLocatoreEvent(GetAllStoreLocatoreEvent event , Emitter<AppState> emit ) async{
    emit( Loading());
    var response = await store_locator_repo.get_stores_locators();
    if(response != null){
      _store_locator_subject.sink.add(response);

      emit( Done(general_model: response));
    }else{
      emit( ErrorLoading(general_model: response));
    }
  }


}

final store_locator_bloc = StoreLocatorBloc();