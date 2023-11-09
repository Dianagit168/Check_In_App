import 'package:check_in_app/index.dart';

class TicketUcImpl {
  late BuildContext _context;
  late Map<String, dynamic> decode;
  final GetRestApi _getRestApi = GetRestApi();
  final PostRestApi _postRestApi = PostRestApi();
  List<RedeemItemModel> redeemItems = [];
  String jsonDataRedeem = "";
  final ValueNotifier<TicketModel> ticketModel = ValueNotifier(TicketModel());

  final ValueNotifier<CountTicketModel> ticketCountModel = ValueNotifier(CountTicketModel());

  final ValueNotifier<int> ticketCount = ValueNotifier(0);

  final TextEditingController ticketController = TextEditingController();

  QRViewController? qrViewController;

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

  Future<void> getCountTicketData() async {
    ticketCountModel.value = await countTicketData();
  }


  Future<CountTicketModel> countTicketData() async {

    try {
      final data = await _getRestApi.getTicketCount();

      decode = json.decode(data.body);

      if (data.statusCode == 200) {
        return CountTicketModel.fromJson(jsonDecode(data.body));
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
    ModernDialog().successMsg(
      _context,
      "Ticket Redeemed\nSuccessfully",
      barrierDismissible: false,
      action2: ElevatedButtonCust(
        tit: 'Close',
        btnColor: const Color.fromRGBO(93, 84, 217, 1),
        textColor: const Color.fromARGB(255, 255, 255, 255),
        borderColor: const Color.fromRGBO(130, 102, 224, 0.5),
        btnHigh: 50,
        onNavigator: () {
          Navigator.pop(_context);
          Navigator.pop(_context);
        },
      ),
    );
  }

  void _handleError(String errorMessage) {
    ModernDialog().errorMsg(
      _context, 
      decode['message'],
      barrierDismissible: false,
      action2: ElevatedButtonCust(
        tit: 'Close',
        btnColor: const Color.fromRGBO(93, 84, 217, 1),
        textColor: const Color.fromARGB(255, 255, 255, 255),
        borderColor: const Color.fromRGBO(130, 102, 224, 0.5),
        btnHigh: 50,
        onNavigator: () {
          Navigator.pop(_context);
          Navigator.pop(_context);
        },
      ),
    );
  }

  void _invalidError() {
    Navigator.pop(_context);
    ModernDialog().errorMsg(_context, "Failed Invalid QR Code").then((value) {
      qrViewController!.resumeCamera().then((value) {
        isScanning = true;
      });
    });
  }
}
