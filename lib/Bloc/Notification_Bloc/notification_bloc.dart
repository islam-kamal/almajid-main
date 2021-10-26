
import 'package:almajidoud/Model/NotificationsModel/notifications_model.dart';
import 'package:almajidoud/Repository/NotificationsRepo/notifications_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';

class NotificationBloc extends Bloc<AppEvent,AppState>{
  NotificationBloc(AppState initialState) : super(initialState);

  BehaviorSubject<NotificationsModel> _notifications_subject =  BehaviorSubject<NotificationsModel>();

  get notifications_subject{
    return _notifications_subject;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is GetAllNotificationEvent){
      yield Loading();
      final response = await notificationsRepository.getAllNotifications();
      if (response.status == true) {
        _notifications_subject.sink.add(response);
        yield Done(model: response);
      } else if (response.status == false) {
        yield ErrorLoading(model: response);
      }
    }else if(event is RemoveNotificationEvent){
      yield Loading();
      final response = await notificationsRepository.remove_notification(event.id);
      if (response.status == true) {
        yield Done(model: response );
      } else if (response.status == false) {
        yield ErrorLoading(model: response);
      }
    }

  }

}

NotificationBloc notificationBloc = NotificationBloc(null);