import 'package:check_in_app/index.dart';

class RedeemTicketScreen extends StatelessWidget {
  final String id;
  final TicketUcImpl ticketUcImpl;
  final TicketModel ticketModel;
  const RedeemTicketScreen({super.key, required this.ticketModel, required this.ticketUcImpl, required this.id});

  @override
  Widget build(BuildContext context) {
    ticketUcImpl.setBuildContext = context;

    // Convert to the desired format for the POST request
    ticketUcImpl.redeemItems = ticketModel.data!.map((itemData) {
      return RedeemItemModel(
        orderId: itemData.orderId!,
        lineItem: itemData.lineItem!,
        qty: 0,
      );
    }).toList();

    return Scaffold(
      appBar: normalAppBar(context, titleAppbar: "Redeem Ticket"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
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
                ? const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text("Data not found", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  )
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
              ),
            ),
    );
  }

  Future<void> _showRedeemConfirmation(BuildContext context) async {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      title: "Ready to REDEEM?",
      showCancelBtn: true,
      confirmBtnText: "Yes",
      cancelBtnText: "No",
      onConfirmBtnTap: () async {
        Navigator.pop(context);
        await ticketUcImpl.redeemTicket(ticketUcImpl.jsonDataRedeem);
      },
    );
  }

  Widget _cardTypeTicket(BuildContext context) {
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Total: ${data.qty}/Redeemed: ${data.used}",
                          style: const TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                    if (data.qty != data.used)
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
    return InputQty(
      maxVal: ticketModel.data![index].qty! - ticketModel.data![index].used!,
      initVal: ticketModel.data![index].qty! - ticketModel.data![index].used!,
      steps: 1,
      minVal: 0,
      qtyFormProps: const QtyFormProps(enableTyping: true),
      onQtyChanged: (value) {
        items[index].qty = value;

        // Convert the updated items list to the desired format
        List<Map<String, dynamic>> convertedItems = items.map((item) {
          return {
            "order_id": item.orderId,
            "line_item": item.lineItem,
            "qty": item.qty,
          };
        }).toList();

        // Create a new variable with the desired format
        Map<String, dynamic> newData = {"items": convertedItems};

        // Convert newData to JSON for printing or further usage
        ticketUcImpl.jsonDataRedeem = jsonEncode(newData);
      },
      decoration: const QtyDecorationProps(
        isBordered: true,
        contentPadding: EdgeInsets.all(10),
        minusBtn: Icon(
          LucideIcons.minus,
          color: Colors.purple,
          size: 35,
        ),
        plusBtn: Icon(
          LucideIcons.plus,
          color: Colors.indigo,
          size: 35,
        ),
      ),
    );
  }
}
