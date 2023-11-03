import 'package:check_in_app/index.dart';

class TicketUcImpl {
  late BuildContext _context;
  late Map<String, dynamic> decode;
  final GetRestApi _getRestApi = GetRestApi();
  final PostRestApi _postRestApi = PostRestApi();
  List<RedeemItemModel> redeemItems = [];
  String jsonDataRedeem = "";
  final ValueNotifier<TicketModel> ticketModel = ValueNotifier(TicketModel());

  late QRViewController qrViewController;

  bool isScanning = true;

  set setBuildContext(BuildContext ctx) {
    _context = ctx;
  }

  Future<void> getTicketData(String id) async {
    ticketModel.value = await queryTicketData(id);
  }


  Future<TicketModel> queryTicketData(String id) async {

    try {
      final data = await _getRestApi.getTicketApi(id: id);

      decode = json.decode(data.body);

      if (data.statusCode == 201) {
        return TicketModel.fromJson(jsonDecode(data.body));
      } else {
        _handleError('Failed to load queryTicketData');
        throw Exception('Failed to load queryTicketData');
      }
    } catch (e) {
      _invalidError();
      throw Exception('Failed Invalid QR Code');
    }
    
  }


  Future<void> redeemTicket(String redeemItem) async {
    final data = await _postRestApi.redeemTicketApi(redeemItem);

    decode = json.decode(data.body);

    if (data.statusCode == 201) {
      _showSuccessAlert("Ticket Redeemed Successfully");
    } else {
      _handleError('Failed to redeemTicket');
    }
    
  }

  void _showSuccessAlert(String message) {
    QuickAlert.show(
      context: _context,
      type: QuickAlertType.success,
      title: message,
      confirmBtnText: "Close",
      onConfirmBtnTap: () async {
        Navigator.pop(_context);
        Navigator.pop(_context);
      },
    );
  }

  void _handleError(String errorMessage) {
    ModernDialog().errorMsg(_context, decode['message']);
  }

  void _invalidError() {
    ModernDialog().errorMsg(_context, "Failed Invalid QR Code").then((value) {
      qrViewController.resumeCamera().then((value) {
        isScanning = true;
      });
    });
  }
}
