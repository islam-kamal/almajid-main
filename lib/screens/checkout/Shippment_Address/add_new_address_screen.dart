import 'package:almajidoud/utils/file_export.dart';

class AddNewAddress extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddNewAddressState();
  }

}
class AddNewAddressState extends State<AddNewAddress>with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(

        ),
      ),
    );
  }

}