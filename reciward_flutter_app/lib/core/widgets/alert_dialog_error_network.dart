import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AlertDialogErrorNetwork {
  late BuildContext context; 
  late VoidCallback onRetry;

  AlertDialogErrorNetwork({required this.context, required this.onRetry}) {

    cerrar = TextButton(
      child: Text("Cerrar App"),
      onPressed: () {
        SystemNavigator.pop();
      },
    );


    reintentar = TextButton(
      child: Text("Reintentar"),
      onPressed: () {
        Navigator.pop(context); 
        onRetry();
      },
    );

    alert = GestureDetector(
      onTap: () {
        
      },
      child: AlertDialog(
        title: Text("Tienes un problema de conexión a internet"),
        content: Text("Revisa tu wifi. Todas las opciones de la app serán limitadas"),
        actions: [
          reintentar,
          cerrar
        ],
      ),
    );
  }

  late Widget reintentar; 
  late Widget cerrar; 
  late Widget alert; 
}
