
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
      print("notification 1");
      yield Loading();
      print("notification 2");
      final response = await notificationsRepository.getAllNotifications();
      print("notification 3");
      if (response.status == true) {
        print("notification 4");
        _notifications_subject.sink.add(response);
        print("notification 5");
        yield Done(model: response);
      } else if (response.status == false) {
        print("notification 6");
        yield ErrorLoading(response);
      }
    }else if(event is RemoveNotificationEvent){
      print("remove_notification 1");
      yield Loading();
      final response = await notificationsRepository.remove_notification(event.id);
      print("remove_notification response : ${response}");
      if (response.status == true) {
        print("remove_notification 2");
        yield Done(model: response );
      } else if (response.status == false) {
        print("remove_notification 3");
        yield ErrorLoading(response);
      }
    }

  }

}

NotificationBloc notificationBloc = NotificationBloc(null);