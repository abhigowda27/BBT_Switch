import '../models/switch_initial.dart';
import 'newswitchinstallation.dart';
import 'package:flutter/material.dart';

class BarCodeDetailsWidget extends StatelessWidget {
  BarCodeDetailsWidget({required this.details, Key? key}) : super(key: key);

  SwitchDetails details;
  // final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        // key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          // leading: FlutterFlowIconButton(
          //   borderColor: Colors.transparent,
          //   borderRadius: 30,
          //   borderWidth: 1,
          //   buttonSize: 60,
          //   icon: Icon(
          //     Icons.arrow_back_rounded,
          //     color: Color(0xFF101213),
          //     size: 30,
          //   ),
          //   onPressed: () async {
          //     context.pop();
          //   },
          // ),
          actions: const [],
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                              child: Text(
                                'QR Code Details',
                                // style: FlutterFlowTheme.of(context)
                                //     .headlineMedium
                                //     .override(
                                //       fontFamily: 'Plus Jakarta Sans',
                                //       color: Color(0xFF101213),
                                //       fontSize: 24,
                                //       fontWeight: FontWeight.w500,
                                //     ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 12,
                        thickness: 1,
                        color: Color(0xFFE0E3E7),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                          child: Container(
                            width: 350,
                            height: 230,
                            decoration: BoxDecoration(
                              color: const Color(0xEE6C43BD),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xFF4B39EF),
                                  offset: Offset(0, 5),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Align(
                              alignment: const AlignmentDirectional(-1, 0),
                              child: Text(
                                'SWITCHID : ${details.switchld}\n\nSSID:${details.switchSSID}\n\nPassword:${details.switchPassword}\n\nPlease NOTE down the password,you will need to configure and change the switch ',
                                textAlign: TextAlign.start,
                                // style: FlutterFlowTheme.of(context)
                                //     .bodyMedium
                                //     .override(
                                //       fontFamily: 'Readex Pro',
                                //       color: FlutterFlowTheme.of(context)
                                //           .primaryBackground,
                                //       fontSize: 20,
                                //     ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-1, 1),
                        child: ElevatedButton(
                          onPressed: () {
                            // print('Button pressed ...');
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Instructions'),
                                content: const Text(
                                    'Below to personalize your configuration you are required to change the switch name and password for security purpose.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NewInstallationPage(
                                                    switchDetails: details,
                                                  )));
                                    },
                                    // Navigator.pop(context, 'Contii'),
                                    child: const Text('Continue'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text('NEXT'),
                          // options: FFButtonOptions(
                          //   height: 40,
                          //   padding:
                          //       EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          //   iconPadding:
                          //       EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          //   color: FlutterFlowTheme.of(context).primary,
                          //   textStyle: FlutterFlowTheme.of(context)
                          //       .titleSmall
                          //       .override(
                          //         fontFamily: 'Readex Pro',
                          //         color: Colors.white,
                          //       ),
                          //   elevation: 3,
                          //   borderSide: BorderSide(
                          //     color: Colors.transparent,
                          //     width: 1,
                          //   ),
                          //   borderRadius: BorderRadius.circular(8),
                          // ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(1, 0),
                        child: ElevatedButton(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          child: const Text("Back"),
                          // options: FFButtonOptions(
                          //   height: 40,
                          //   padding:
                          //       EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                          //   iconPadding:
                          //       EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          //   color: FlutterFlowTheme.of(context).primary,
                          //   textStyle: FlutterFlowTheme.of(context)
                          //       .titleSmall
                          //       .override(
                          //         fontFamily: 'Readex Pro',
                          //         color: Colors.white,
                          //       ),
                          //   elevation: 3,
                          //   borderSide: BorderSide(
                          //     color: Colors.transparent,
                          //     width: 1,
                          //   ),
                          //   borderRadius: BorderRadius.circular(8),
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
