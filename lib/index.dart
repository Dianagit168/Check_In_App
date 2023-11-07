// ====================> Cores <====================
export 'package:flutter/material.dart';
export 'dart:convert';
export 'package:check_in_app/main.dart';
export 'package:flutter/foundation.dart';
export 'package:http/http.dart';
export 'dart:io';
export 'package:flutter/services.dart';
export 'package:quickalert/quickalert.dart';
export 'package:check_in_app/router.dart';

// ====================> Packages <====================
export 'package:lucide_icons/lucide_icons.dart';
export 'package:qr_code_scanner/qr_code_scanner.dart';
export 'package:lottie/lottie.dart';
export 'package:flutter_dotenv/flutter_dotenv.dart';
export 'package:input_quantity/input_quantity.dart';
export 'package:flutter_secure_storage/flutter_secure_storage.dart';
export 'package:go_router/go_router.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:animated_flip_counter/animated_flip_counter.dart';
export 'package:google_fonts/google_fonts.dart';
export 'package:slidable_button/slidable_button.dart';

// ====================> Data API <====================
export 'package:check_in_app/data/api/post_rest_api.dart';
export 'package:check_in_app/data/api/secure_storage.dart';
export 'package:check_in_app/data/api/db_key.dart';
export 'package:check_in_app/data/api/get_rest_api.dart';

// ====================> Domain Usecases <====================
export 'package:check_in_app/domain/usecases/auth_uc_impl.dart';
export 'package:check_in_app/domain/usecases/ticket_uc_impl.dart';

// ====================> Domain Model <====================
export 'package:check_in_app/domain/models/event_m.dart';
export 'package:check_in_app/domain/models/auth_m.dart';
export 'package:check_in_app/domain/models/ticket_m.dart';
export 'package:check_in_app/domain/models/redeem_item_m.dart';
export 'package:check_in_app/domain/models/count_ticket_m.dart';

// ====================> Presentation Screen <====================
export 'package:check_in_app/presentation/screen/register_screen.dart';
export 'package:check_in_app/presentation/screen/login_screen.dart';
export 'package:check_in_app/presentation/screen/qr_scanner.dart';
export 'package:check_in_app/presentation/screen/runwithsai_screen.dart';
export 'package:check_in_app/presentation/screen/redeem_ticket_screen.dart';

// ====================> Presentation Widget <====================
export 'package:check_in_app/presentation/widget/button_cus.dart';
export 'package:check_in_app/presentation/widget/appbar_cus.dart';
export 'package:check_in_app/presentation/widget/alert_dialog_cus.dart';
export 'package:check_in_app/presentation/widget/glassmorphism_cus.dart';
export 'package:check_in_app/presentation/widget/textfield_cus.dart';
export 'package:check_in_app/presentation/widget/footer_powered_by.dart';