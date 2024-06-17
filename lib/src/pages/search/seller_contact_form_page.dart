import 'package:customsoft_exam/src/models/seller_contact_model.dart';
import 'package:customsoft_exam/src/utils/utils.dart';
import 'package:customsoft_exam/src/widgets/reactive_text_field.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SellerContactFormPage extends StatefulWidget {
  final SellerContactModel sellerContactModel;
  const SellerContactFormPage({super.key, required this.sellerContactModel});

  @override
  State<SellerContactFormPage> createState() => _SellerContactFormPageState();
}

class _SellerContactFormPageState extends State<SellerContactFormPage> {
  SellerContactFormValidation formValidation = SellerContactFormValidation();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contacto")),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildContactAvatar(context),
            ],
          ),
          Row(
            children: [
              Icon(Icons.phone),
              SizedBox(width: 10),
              Text("Teléfono")
            ],
          ),
          SizedBox(height: 5),
          InkWell(
            onTap: () async {
              await doCall();
            },
            borderRadius: BorderRadius.circular(5),
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
              ),
              child: Row(
                children: [
                  Text(widget.sellerContactModel.phone),
                  Spacer(),
                  Text(
                    "Llamar",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 20),

          //Message form
          ReactiveForm(
            formGroup: formValidation.messageForm,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.mail_outline),
                    SizedBox(width: 10),
                    Text("Correo")
                  ],
                ),
                SizedBox(height: 10),
                Text("Nombre", style: Theme.of(context).textTheme.bodyLarge),
                ReactiveFieldFormWidget(
                  placeholder: "",
                  formControlName: "name",
                  enableSuffix: false,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                ),
                SizedBox(height: 10),
                Text("Correo", style: Theme.of(context).textTheme.bodyLarge),
                ReactiveFieldFormWidget(
                  placeholder: "",
                  formControlName: "email",
                  enableSuffix: false,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 10),
                Text("Mensaje", style: Theme.of(context).textTheme.bodyLarge),
                ReactiveFieldFormWidget(
                  placeholder: "",
                  formControlName: "message",
                  enableSuffix: false,
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 5,
                ),
                ReactiveFormConsumer(
                  builder: (buildContext, form, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: form.valid
                              ? () async {
                                  await sendMail();
                                }
                              : null,
                          child: Text("Enviar correo"),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column _buildContactAvatar(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 41,
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: Icon(
              Icons.person,
              size: 60,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          widget.sellerContactModel.name,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  Future<void> doCall() async {
    await LaunchService.call(widget.sellerContactModel.phone);
  }

  Future<void> sendMail() async {
    String name = formValidation.name;
    String email = formValidation.email;
    String message = formValidation.message;

    String subject = 'CONTACTO - ANUNCIOS EMPRESARIAL';
    String body =
        """SE RECIBIO UN COMENTARIO DESDE EL SISTEMA DE ANUNCIOS EMPRESARIALES CON LA SIGUIENTE INFORMACÓN DE CONTACTO
        
        NOMBRE: $name
        CORREO CONTACTO: $email
        MENSAJE:
        $message""";

    //TODO: external app or api mailing
    await LaunchService.sendMail(
      'callme.delivery.app@gmail.com',
      subject: subject,
      body: body,
    );
  }
}

class SellerContactFormValidation {
  static String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  FormGroup messageForm = FormGroup({
    'name': FormControl<String>(
      validators: [Validators.required, Validators.maxLength(50)],
    ),
    'email': FormControl<String>(
      validators: [
        Validators.required,
        Validators.pattern(RegExp(emailPattern))
      ],
    ),
    'message': FormControl<String>(
      validators: [
        Validators.required,
        Validators.maxLength(100),
      ],
    ),
  });

  String get name => messageForm.value['name'] as String;
  String get email => messageForm.value['email'] as String;
  String get message => messageForm.value['message'] as String;
}
