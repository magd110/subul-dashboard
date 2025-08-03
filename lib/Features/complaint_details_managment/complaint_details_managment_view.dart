import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/complaint_details_managment_body.dart';
import 'package:subul_dashboard2/Features/complaint_details_managment/presentation/manager/complaint_details_cubit.dart';

import 'package:subul_dashboard2/core/utils/service_locator.dart';

class ComplaintDetailsManagmentView extends StatelessWidget {
  final int complaintid;
 

  const ComplaintDetailsManagmentView({
    super.key,
    required this.complaintid,

  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<ComplaintDetailsCubit>()
            ..fetchComplaintDetails(complaintId: complaintid),
        ),
      ],
      child: ComplaintDetailsManagmentBody(complaintid: complaintid),
    );
  }
}


