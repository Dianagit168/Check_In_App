import 'package:check_in_app/index.dart';

class RedeemTicketScreen extends StatelessWidget {
  final String id;
  final TicketUcImpl ticketUcImpl;
  final TicketModel ticketModel;

  const RedeemTicketScreen({
    super.key,
    required this.ticketModel,
    required this.ticketUcImpl,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    ticketUcImpl.setBuildContext = context;

    ticketUcImpl.redeemItems = ticketModel.data!.map((itemData) {
      return RedeemItemModel(
        orderId: itemData.orderId!,
        lineItem: itemData.lineItem!,
        qty: itemData.qty!,
      );
    }).toList();

    return Scaffold(
      appBar: normalAppBar(context, titleAppbar: "Redeem Ticket"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  'assets/images/runcover.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ticketModel.data!.isEmpty
                ? _noDataFound()
                : _cardTypeTicket(context),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ticketModel.data!.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButtonCust(
                tit: 'REDEEM TICKET',
                iconData: LucideIcons.ticket,
                textColor: const Color.fromRGBO(130, 102, 224, 1),
                iconColor: const Color.fromRGBO(130, 102, 224, 1),
                borderColor: const Color.fromRGBO(130, 102, 224, 1),
                btnHigh: 50,
                onNavigator: () async {
                  await _showRedeemConfirmation(context);
                },
                disabled:
                    !ticketModel.data!.every((item) => item.qty! > item.used!),
              ),
            ),
    );
  }

  Widget _noDataFound() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(
              "assets/images/no-data.svg",
              width: 200,
              height: 200,
            ),
          ),
          const Text("Data not found",
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ],
      ),
    );
  }

  Future<void> _showRedeemConfirmation(BuildContext context) async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      barrierColor: const Color.fromRGBO(130, 102, 224, 0.2),
      title: "Ready to REDEEM?",
      showCancelBtn: true,
      confirmBtnText: "Yes",
      confirmBtnColor: const Color.fromRGBO(130, 102, 224, 1),
      cancelBtnText: "No",
      onConfirmBtnTap: () async {
        Navigator.pop(context);

        if (ticketUcImpl.jsonDataRedeem == "") {
          _prepareAndRedeem();
        } else {
          await ticketUcImpl.redeemTicket(ticketUcImpl.jsonDataRedeem);
        }
      },
    );
  }

  void _prepareAndRedeem() async {
    List<Map<String, dynamic>> convertedItems =
        ticketUcImpl.redeemItems.map((item) {
      return {
        "order_id": item.orderId,
        "line_item": item.lineItem,
        "qty": item.qty,
      };
    }).toList();

    Map<String, dynamic> newData = {"items": convertedItems};

    ticketUcImpl.jsonDataRedeem = jsonEncode(newData);

    await ticketUcImpl.redeemTicket(ticketUcImpl.jsonDataRedeem);
  }

  Widget _cardTypeTicket(BuildContext context) {
    return ticketModel.data!.every((item) => item.qty! == item.used!)
        ? _ticketRedeemed()
        : _ticketCard(context);
  }

  Widget _ticketRedeemed() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(
              "assets/images/empty.svg",
              width: 200,
              height: 200,
            ),
          ),
          const Text("Ticket Redeemed",
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ],
      ),
    );
  }

  Widget _ticketCard(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: ticketModel.data!.length,
            itemBuilder: (context, index) {
              final data = ticketModel.data![index];

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...[
                      const Text("Run With Sai",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Total: ${data.qty}/Redeemed: ${data.used}",
                        style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(130, 102, 224, 1),
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: _amountBtn(ticketUcImpl.redeemItems, index),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _amountBtn(List<RedeemItemModel> items, int index) {
    return InputQty.int(
      maxVal: ticketModel.data![index].qty! - ticketModel.data![index].used!,
      initVal: ticketModel.data![index].qty! - ticketModel.data![index].used!,
      steps: 1,
      minVal: 1,
      qtyFormProps: QtyFormProps(
        enableTyping: true,
        enabled: ticketModel.data![index].qty! ==
                ticketModel.data![index].used!
            ? false
            : true,
      ),
      onQtyChanged: (value) {
        items[index].qty = value;

        List<Map<String, dynamic>> convertedItems = items.map((item) {
          return {
            "order_id": item.orderId,
            "line_item": item.lineItem,
            "qty": item.qty,
          };
        }).toList();

        Map<String, dynamic> newData = {"items": convertedItems};

        ticketUcImpl.jsonDataRedeem = jsonEncode(newData);

        print(ticketUcImpl.jsonDataRedeem);
      },
      decoration: const QtyDecorationProps(
        isBordered: true,
        btnColor: Color.fromRGBO(130, 102, 224, 1),
        iconColor: Color.fromRGBO(130, 102, 224, 1),
        plusButtonConstrains: BoxConstraints(minWidth: 55),
        minusButtonConstrains: BoxConstraints(minWidth: 55),
        contentPadding: EdgeInsets.all(15),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        minusBtn: Icon(
          LucideIcons.minusCircle,
          color: Colors.purple,
          size: 35,
        ),
        plusBtn: Icon(
          LucideIcons.plusCircle,
          color: Colors.indigo,
          size: 35,
        ),
      ),
    );
  }
}
