import 'package:check_in_app/domain/models/redeem_item_m.dart';
import 'package:check_in_app/index.dart';
import 'package:quickalert/quickalert.dart';

class TicketUcImpl {

  BuildContext? _context;

  set setBuildContext(BuildContext ctx) {
    _context = ctx;
  }

  Map<String, dynamic>? decode;

  final GetRestApi _getRestApi = GetRestApi();

  final PostRestApi _postRestApi = PostRestApi();

  List<RedeemItemModel> redeemItems = [];

  String jsonDataRedeem = "";

  ValueNotifier<TicketModel> ticketModel = ValueNotifier(TicketModel());


  Future<void> getTicketData(String id) async {

    ticketModel.value = await queryTicketData(id);

  }

  Future<TicketModel> queryTicketData(String id) async {
    
    return await _getRestApi.getTicketApi(id: id).then((data) {

      decode = json.decode(data.body);

      if(data.statusCode == 201) {

        return TicketModel.fromJson(jsonDecode(data.body));      
      
      }
      else {
        ModernDialog().errorMsg(_context!, decode!["message"]);
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load tansfer history ticket data');
      }

    });
  }

  Future<void> redeemTicket(String redeemItem) async {
    
    return await _postRestApi.redeemTicketApi(redeemItem).then((data) {

      decode = json.decode(data.body);

      if(data.statusCode == 201) {

        QuickAlert.show(
          context: _context!,
          type: QuickAlertType.success,
          title: "Ticket Redeemed Successfully",
          confirmBtnText: "Close",
          onConfirmBtnTap: () async {
            // Close Dailog
            Navigator.pop(_context!);

            // Close screen redeem detail to scanner
            Navigator.pop(_context!);
          },
        );
      
      }
      else {
        ModernDialog().errorMsg(_context!, decode!["message"]);
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load data');
      }

    });
  }
  
}