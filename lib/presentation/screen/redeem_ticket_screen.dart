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

    print("variant ${ticketModel.data![0].id}");

    print(dotenv.env["API_URL"]);

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
      bottomNavigationBar: ticketModel.data!.every((item) => item.qty! == item.used!)
          ? const SizedBox()
          : Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 50, top: 0),
            child: HorizontalSlidableButton(
              buttonWidth: 100.0,
              height: 50,
              color: const Color.fromRGBO(242, 242, 242, 1),
              buttonColor: const Color.fromRGBO(93, 84, 217, 1),
              dismissible: true,
              label: const Center(child: Icon(LucideIcons.arrowRight, color: Colors.white)),
              completeSlideAt: 0.8,
              onChanged: (position) async {
                if (position == SlidableButtonPosition.end) {
                  await _showRedeemConfirmation(context);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Swipe Redeem Ticket', 
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
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
          Text("Data not found", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20)),
        ],
      ),
    );
  }

  Future<void> _showRedeemConfirmation(BuildContext context) async {
    if (ticketUcImpl.jsonDataRedeem == "") {
      _prepareAndRedeem();
    } else {
      await ticketUcImpl.redeemTicket(ticketUcImpl.jsonDataRedeem);
    }
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
          Text("Ticket Already Used", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20)),
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
                      Text(ticketModel.data![index].variant!, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Total: ${data.qty}/Redeemed: ${data.used}",
                        style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: const Color.fromRGBO(130, 102, 224, 1),
                            fontWeight: FontWeight.bold),
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
        btnColor: Color.fromRGBO(93, 84, 217, 1),
        iconColor: Color.fromRGBO(93, 84, 217, 1),
        plusButtonConstrains: BoxConstraints(minWidth: 55),
        minusButtonConstrains: BoxConstraints(minWidth: 55),
        contentPadding: EdgeInsets.all(15),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        minusBtn: Icon(
          Icons.remove_circle_rounded,
          color: Color.fromRGBO(0, 0, 0, 1),
          size: 35,
        ),
        plusBtn: Icon(
          Icons.add_circle_sharp,
          color: Color.fromRGBO(93, 84, 217, 1),
          size: 35,
        ),
      ),
    );
  }
}
