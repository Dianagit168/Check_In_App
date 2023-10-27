import 'package:check_in_app/index.dart';

class RedeemTicketScreen extends StatelessWidget {
  const RedeemTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: normalAppBar(context, titleAppbar: "Redeem Ticket"),
      body: Column(
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
      
          _cardTypeTicket(context),

          const Spacer(),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButtonCust(
                tit: 'REDEEM TICKET',
                iconData: LucideIcons.ticket,
                textColor: const Color.fromRGBO(130, 102, 224, 1),
                iconColor: const Color.fromRGBO(130, 102, 224, 1),
                borderColor: const Color.fromRGBO(130, 102, 224, 1),
                btnHigh: 50,
                onNavigator: () async {
                      
                },
              ),
            ),
          ),
      
        ],
      ),
    );
  }

  Widget _cardTypeTicket(BuildContext context){
    return Card(
      margin: const EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Text(
                      "5km Running",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
            
                    const Spacer(),
              
                    _amountBtn(),
                  ],
                ),
              ),
            
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Text(
                      "10km Running",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
            
                    const Spacer(),
              
                    _amountBtn(),
                  ],
                ),
              ),
            
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Text(
                      "21km Running",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
            
                    const Spacer(),
              
                    _amountBtn(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _amountBtn() {
    return const InputQty(
      maxVal: 100,
      initVal: 0,
      steps: 1,
      minVal: 0,
      qtyFormProps: QtyFormProps(enableTyping: true),
      decoration: QtyDecorationProps(
        isBordered: false,
        minusBtn: Icon(
          LucideIcons.minusCircle,
          color: Colors.purple,
        ),
        plusBtn: Icon(
          LucideIcons.plusCircle, 
          color: Colors.indigo
        ),
      ),
    );
  }

}