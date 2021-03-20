import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tcp_workers/app/common/appbar.dart';
import 'package:flutter_screenutil/size_extension.dart';

class TermsandConditions extends StatefulWidget {
  TermsandConditions({Key key}) : super(key: key);

  @override
  _TermsandConditionsState createState() => _TermsandConditionsState();
}

class _TermsandConditionsState extends State<TermsandConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        actions: [],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.sp),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                title("TÉRMINOS DE SERVICIO"),
                SizedBox(height: 20.sp),
                Text("---"),
                SizedBox(height: 20.sp),
                title("INFORMACIÓN GENERAL"),
                SizedBox(height: 20.sp),
                condicion(
                    "Esta aplicación y pagina web llamada Techno Construction Plus es propiedad y está operado por Techno Business Plus Inc. En todo el sitio, los términos “nosotros”, “nos” y “nuestro” se refieren a Techno Business Plus Inc. Estos Términos establecen los términos y condiciones bajo los cuales el cliente puede usar nuestra página, aplicación y servicios ofrecidos por nosotros. Esta página web ofrece a los visitantes la posibilidad de llevar el control de horas de trabajo realizadas en un periodo de tiempo definido por el usuario. Por lo tanto, estas Condiciones de uso constituyen un acuerdo entre usted y Techno Business Plus Inc."),
                SizedBox(height: 20.sp),
                condicion(
                    "Al visitar nuestro sitio y/o comprar algo de nosotros, participas en nuestro “Servicio” y aceptas los siguientes términos y condiciones, incluidos todos los términos y condiciones adicionales y las políticas a las que se hace referencia en el presente documento y/o disponible a través de hipervínculos. Estas Condiciones de Servicio se aplican a todos los usuarios del sitio, incluyendo sin limitación a usuarios que sean navegadores, proveedores, clientes, comerciantes, y/o colaboradores de contenido."),
                SizedBox(height: 20.sp),
                condicion(
                  "Por favor, lee estos Términos de Servicio cuidadosamente antes de acceder o utilizar nuestro sitio web. Al acceder o utilizar cualquier parte del sitio, estás aceptando los Términos de Servicio. Si no estás de acuerdo con todos los términos y condiciones de este acuerdo, entonces no deberías acceder a la página web o usar cualquiera de los servicios. Si los Términos de Servicio son considerados una oferta, la aceptación está expresamente limitada a estos Términos de Servicio.",
                ),
                SizedBox(height: 20.sp),
                condicion(
                  "Cualquier función nueva o herramienta que se añadan a la aplicación actual, también estarán sujetas a los Términos de Servicio. Puedes revisar la versión actualizada de los Términos de Servicio, en cualquier momento en esta página. Nos reservamos el derecho de actualizar, cambiar o reemplazar cualquier parte de los Términos de Servicio mediante la publicación de actualizaciones y/o cambios en nuestro sitio web. Es tu responsabilidad chequear esta página periódicamente para verificar cambios. Su uso continuo o el acceso al sitio web después de la publicación de cualquier cambio constituye la aceptación de dichos cambios.",
                ),
                SizedBox(height: 20.sp),
                condicion(
                  "Cualquier función nueva o herramienta que se añadan a la aplicación actual, también estarán sujetas a los Términos de Servicio. Puedes revisar la versión actualizada de los Términos de Servicio, en cualquier momento en esta página. Nos reservamos el derecho de actualizar, cambiar o reemplazar cualquier parte de los Términos de Servicio mediante la publicación de actualizaciones y/o cambios en nuestro sitio web. Es tu responsabilidad chequear esta página periódicamente para verificar cambios. Su uso continuo o el acceso al sitio web después de la publicación de cualquier cambio constituye la aceptación de dichos cambios.",
                ),
                SizedBox(height: 20.sp),
                title(
                    "SECCIÓN 1 - TÉRMINOS DE LA PAGINA WEB Y APLICACION EN LINEA"),
                SizedBox(height: 20.sp),
                condicion(
                  "Al utilizar este sitio, declaras que tienes al menos la mayoría de edad en tu país o estado de residencia.\n\nNo puedes usar nuestros productos con ningún propósito ilegal o no autorizado, tampoco puedes, en el uso del Servicio, violar cualquier ley en tu jurisdicción incluyendo pero no limitado a las leyes de derecho de autor. \n\nNo debes transmitir gusanos, virus o cualquier código de naturaleza destructiva.\n\nEl incumplimiento o violación de cualquiera de estos Términos darán lugar al cese inmediato de tus Servicios.",
                ),
                SizedBox(height: 20.sp),
                title("SECCIÓN 2 - CONDICIONES GENERALES"),
                SizedBox(height: 20.sp),
                condicion(
                    "Nos reservamos el derecho de rechazar la prestación de servicio a cualquier usuario, cualquier cliente, cualquier empresa y cualquier persona, por cualquier motivo y en cualquier momento."),
                SizedBox(height: 20.sp),
                condicion(
                    "Entiendes que tu contenido (sin incluir la información de tu tarjeta de crédito), puede ser transferida sin encriptar e involucrar (a) transmisiones a través de varias redes; y (b) cambios para ajustarse o adaptarse a los requisitos técnicos de conexión de redes o dispositivos. La información de tarjetas de crédito está siempre encriptada durante la transferencia a través de las redes."),
                SizedBox(height: 20.sp),
                condicion(
                    "Los títulos utilizados en este acuerdo se incluyen solo por conveniencia y no limita o afecta a estos Términos."),
                SizedBox(height: 20.sp),
                title(
                    "SECCIÓN 3 - EXACTITUD, EXHAUSTIVIDAD Y ACTUALIDAD DE LA INFORMACIÓN"),
                SizedBox(height: 20.sp),
                condicion(
                    "Este sitio puede contener cierta información histórica. La información histórica, no es necesariamente actual y es provista únicamente para tu referencia.  Nos reservamos el derecho de modificar los contenidos de este sitio en cualquier momento, pero no tenemos obligación de actualizar cualquier información en nuestro sitio. Aceptas que es tu responsabilidad de monitorear los cambios en nuestro sitio."),
                SizedBox(height: 20.sp),
                title("SECCIÓN 4 - MODIFICACIONES AL SERVICIO Y PRECIOS"),
                SizedBox(height: 20.sp),
                condicion(
                    "Los precios de nuestros productos están sujetos a cambio sin aviso.\nNos reservamos el derecho de modificar o descontinuar el Servicio (o cualquier parte del contenido) en cualquier momento sin aviso previo.\nNo seremos responsables ante usted o alguna tercera parte por cualquier modificación, cambio de precio, suspensión o discontinuidad del Servicio."),
                SizedBox(height: 20.sp),
                title("SECCIÓN 5 - PRODUCTOS O SERVICIOS (si aplicable)"),
                SizedBox(height: 20.sp),
                condicion(
                    "Nos reservamos el derecho, pero no estamos obligados, para limitar las ventas de nuestros productos o servicios a cualquier persona, región geográfica o jurisdicción.  Podemos ejercer este derecho basados en cada caso. Nos reservamos el derecho de limitar las cantidades de los productos o servicios que ofrecemos. Todas las descripciones de productos o precios de los productos están sujetos a cambios en cualquier momento sin previo aviso, a nuestra discreción. Nos reservamos el derecho de descontinuar cualquier producto en cualquier momento. "),
                SizedBox(height: 20.sp),
                title(
                    "SECCIÓN 6 - EXACTITUD DE FACTURACIÓN E INFORMACIÓN DE CUENTA"),
                SizedBox(height: 20.sp),
                condicion(
                    "El cliente se compromete a proporcionar información actual, completa y precisa de la compra y cuenta utilizada para todas las compras realizadas en nuestra aplicación. El cliente se compromete a actualizar rápidamente su cuenta y otra información, incluyendo la dirección de correo electrónico, números de tarjetas de crédito y fechas de vencimiento, para que podamos completar su transacción y contactarle cuando sea necesario."),
                SizedBox(height: 20.sp),
                title("SECCIÓN 7 - ENLACES DE TERCERAS PARTES"),
                SizedBox(height: 20.sp),
                condicion(
                    "Cierto contenido, productos y servicios disponibles vía nuestro Servicio puede incluir material de terceras partes."),
                SizedBox(height: 20.sp),
                condicion(
                    "Enlaces de terceras partes en este sitio pueden direccionar al cliente a sitios web de terceras partes que no están afiliadas con nosotros. No nos responsabilizamos de examinar o evaluar el contenido con exactitud y no garantizamos ni tendremos ninguna obligación o responsabilidad por cualquier material de terceros o sitios web, o de cualquier material, productos o servicios de terceros."),
                SizedBox(height: 20.sp),
                condicion(
                    "No nos hacemos responsables de cualquier daño o daños relacionados con la adquisición o utilización de bienes, servicios, recursos, contenidos, o cualquier otra transacción realizada en conexión con sitios web de terceros.  Por favor revise cuidadosamente las políticas y prácticas de terceros y asegúrese de entenderlas antes de participar en cualquier transacción. Quejas, reclamos, inquietudes o preguntas con respecto a productos de terceros deben ser dirigidas a la tercera parte."),
                SizedBox(height: 20.sp),
                title(
                    "SECCIÓN 8 - COMENTARIOS DE USUARIO, CAPTACIÓN Y OTROS ENVÍOS"),
                SizedBox(height: 20.sp),
                condicion(
                    "Si, a pedido nuestro, envías ciertas presentaciones específicas (por ejemplo la participación en concursos) o sin un pedido de nuestra parte envías ideas creativas, sugerencias, proposiciones, planes, u otros materiales, ya sea en línea, por email, por correo postal, o de otra manera (colectivamente, 'comentarios'), aceptas que podamos, en cualquier momento, sin restricción, editar, copiar, publicar, distribuir, traducir o utilizar por cualquier medio comentarios que nos haya enviado. No tenemos ni tendremos ninguna obligación (1) de mantener ningún comentario confidencialmente; (2) de pagar compensación por comentarios; o (3) de responder a comentarios."),
                SizedBox(height: 20.sp),
                condicion(
                    "Nosotros podemos, pero no tenemos obligación de, monitorear, editar o remover contenido que consideremos sea ilegítimo, ofensivo, amenazante, calumnioso, difamatorio, pornográfico, obsceno u objetable o viole la propiedad intelectual de cualquiera de las partes o los Términos de Servicio."),
                SizedBox(height: 20.sp),
                condicion(
                    "El cliente acepta que sus comentarios no violarán los derechos de terceras partes, incluyendo derechos de autor, marca, privacidad, personalidad u otro derecho personal o de propiedad. Asimismo, el Cliente acepta que sus comentarios no contienen material difamatorio o ilegal, abusivo u obsceno, o contienen virus informáticos u otro malware que pudiera, de alguna manera, afectar el funcionamiento del Servicio o de cualquier sitio web relacionado.  El cliente no puede utilizar una dirección de correo electrónico falsa, usar otra identidad que no sea legítima, o engañar a terceras partes o a nosotros en cuanto al origen de sus comentarios.  El cliente es el único responsable por los comentarios que hace y su precisión.  No nos hacemos responsables y no asumimos ninguna obligación con respecto a los comentarios publicados por el cliente o cualquier tercer parte."),
                SizedBox(height: 20.sp),
                title("SECCIÓN 9 - USOS PROHIBIDOS"),
                SizedBox(height: 20.sp),
                condicion(
                    "En adición a otras prohibiciones como se establece en los Términos de Servicio, se prohíbe el uso del sitio o su contenido: (a) para ningún propósito ilegal; (b) para pedirle a otros que realicen o participen en actos ilícitos; (c) para violar cualquier regulación, reglas, leyes internacionales, federales, provinciales o estatales, u ordenanzas locales; (d) para infringir o violar el derecho de propiedad intelectual nuestro o de terceras partes; (e) para acosar, abusar, insultar, dañar, difamar, calumniar, desprestigiar, intimidar o discriminar por razones de género, orientación sexual, religión, etnia, raza, edad, nacionalidad o discapacidad; (f) para presentar información falsa o engañosa; (g) para cargar o transmitir virus o cualquier otro tipo de código malicioso que sea o pueda ser utilizado en cualquier forma que pueda comprometer el funcionamiento del Servicio o de cualquier sitio web relacionado, otros sitios o Internet; (h) para recopilar o rastrear información personal de otros; (i) para generar spam, phish, pharm, pretext, spider, crawl, o scrape; (j) para cualquier propósito obsceno o inmoral; o (k) para interferir con o burlar los elementos de seguridad del Servicio o cualquier sitio web relacionado, otros sitios o Internet. Nos reservamos el derecho de suspender el uso del Servicio o de cualquier sitio web relacionado por violar cualquiera de los ítems de los usos prohibidos."),
                SizedBox(height: 20.sp),
                title(
                    "SECCIÓN 10 - EXCLUSIÓN DE GARANTÍAS; LIMITACIÓN DE RESPONSABILIDAD"),
                SizedBox(height: 20.sp),
                condicion(
                    'No garantizamos ni aseguramos que el uso de nuestro servicio será ininterrumpido, puntual, seguro o libre de errores.\n\nEl cliente acepta que de vez en cuando podemos quitar el servicio por períodos de tiempo indefinidos por causas de actualizaciones o mantenimiento a la aplicacion.\n\nEl cliente acepta expresamente que el uso de, o la posibilidad de utilizar el servicio es bajo su propio riesgo.  El servicio y todos los productos y servicios proporcionados a través del servicio son (salvo lo expresamente manifestado por nosotros) proporcionados "tal cual" y "según esté disponible" para su uso, sin ningún tipo de representación, garantías o condiciones de ningún tipo, ya sea expresa o implícita, incluidas todas las garantías o condiciones implícitas de comercialización, calidad comercializable, la aptitud para un propósito particular, durabilidad, título y no infracción.'),
                SizedBox(height: 20.sp),
                condicion(
                    'En ningún caso Techno Business Plus Inc., nuestros directores, funcionarios, empleados, afiliados, agentes, contratistas, internos, proveedores, prestadores de servicios o licenciantes serán responsables por cualquier daño, pérdida, reclamo, o daños directos, indirectos, incidentales, punitivos, especiales o consecuentes de cualquier tipo, incluyendo, sin limitación, pérdida de beneficios, pérdida de ingresos, pérdida de ahorros, pérdida de datos, costos de reemplazo, o cualquier daño similar, ya sea basado en contrato, agravio (incluyendo negligencia), responsabilidad estricta o de otra manera, como consecuencia del uso de cualquiera de los servicios o productos adquiridos mediante el servicio, o por cualquier otro reclamo relacionado de alguna manera con el uso del servicio o cualquier producto, incluyendo pero no limitado, a cualquier error u omisión en cualquier contenido, o cualquier pérdida o daño de cualquier tipo incurridos como resultados de la utilización del servicio o cualquier contenido (o producto) publicado, transmitido, o que se pongan a disposición a través del servicio, incluso si se avisa de su posibilidad.  Debido a que algunos estados o jurisdicciones no permiten la exclusión o la limitación de responsabilidad por daños consecuenciales o incidentales, en tales estados o jurisdicciones, nuestra responsabilidad se limitará en la medida máxima permitida por la ley.'),
                SizedBox(height: 20.sp),
                title('SECCIÓN 11 - INDEMNIZACIÓN'),
                SizedBox(height: 20.sp),
                condicion(
                    'Aceptas indemnizar, defender y mantener indemne Techno Business Plus Inc. y nuestras marcas registradas, nuestras matrices, subsidiarias, afiliados, socios, funcionarios, directores, agentes, contratistas, concesionarios, proveedores de servicios, subcontratistas, proveedores, internos y empleados, de cualquier reclamo o demanda, incluyendo honorarios razonables de abogados, hechos por cualquier tercero a causa o como resultado de su incumplimiento de las Condiciones de Servicio o de los documentos que incorporan como referencia, o la violación de cualquier ley o de los derechos de un tercero.'),
                SizedBox(height: 20.sp),
                title('SECCIÓN 12 - DIVISIBILIDAD'),
                SizedBox(height: 20.sp),
                condicion(
                    'En el caso de que se determine que cualquier disposición de estas Condiciones de Servicio sea ilegal, nula o inejecutable, dicha disposición será, no obstante, efectiva a obtener la máxima medida permitida por la ley aplicable, y la parte no exigible se considerará separada de estos Términos de Servicio, dicha determinación no afectará la validez de aplicabilidad de las demás disposiciones restantes.'),
                SizedBox(height: 20.sp),
                title('SECCIÓN 13 - RESCISIÓN'),
                SizedBox(height: 20.sp),
                condicion(
                    'Las obligaciones y responsabilidades de las partes que hayan incurrido con anterioridad a la fecha de terminación sobrevivirán a la terminación de este acuerdo a todos los efectos.\n\nEstas Condiciones de servicio son efectivos a menos que y hasta que sea terminado por usted o nosotros. Puede terminar estos Términos de Servicio en cualquier momento por avisarnos que ya no desea utilizar nuestros servicios, o cuando deje de usar nuestro sitio.\n\nSi a nuestro juicio, falla, o se sospecha que han fallado, en el cumplimiento de cualquier término o disposición de estas Condiciones de Servicio, también podemos terminar este acuerdo en cualquier momento sin previo aviso, y seguirá siendo responsable de todos los montos adeudados hasta incluida la fecha de terminación; y/o en consecuencia podemos negarle el acceso a nuestros servicios (o cualquier parte del mismo).'),
                SizedBox(height: 20.sp),
                condicion(
                    'Nuestra falla para ejercer o hacer valer cualquier derecho o disposición de estas Condiciones de Servicio no constituirá una renuncia a tal derecho o disposición.\n\nEstas Condiciones del servicio y las políticas o reglas de operación publicadas por nosotros en este sitio o con respecto al servicio constituyen el acuerdo completo y el entendimiento entre usted y nosotros y rigen el uso del Servicio y reemplaza cualquier acuerdo, comunicaciones y propuestas anteriores o contemporáneas, ya sea oral o escrita, entre usted y nosotros (incluyendo, pero no limitado a, cualquier versión previa de los Términos de Servicio).\n\nCualquier ambigüedad en la interpretación de estas Condiciones del servicio no se interpretarán en contra del grupo de redacción.'),
                SizedBox(height: 20.sp),
                title('SECCIÓN 15 - LEY'),
                SizedBox(height: 20.sp),
                condicion(
                    'Estas Condiciones del servicio y cualquier acuerdo aparte en el que te proporcionemos servicios se regirán e interpretarán en conformidad con las leyes de 5764 Wingate drive, Orlando, FL, 32839, United States.'),
                SizedBox(height: 20.sp),
                title('SECCIÓN 16 - CAMBIOS EN LOS TÉRMINOS DE SERVICIO'),
                SizedBox(height: 20.sp),
                condicion(
                    'Puede revisar la versión más actualizada de los Términos de Servicio en cualquier momento en esta página.\n\nNos reservamos el derecho, a nuestra discreción, de actualizar, modificar o reemplazar cualquier parte de estas Condiciones del servicio mediante la publicación de las actualizaciones y los cambios en nuestro sitio web. Es su responsabilidad revisar nuestro sitio web periódicamente para verificar los cambios. El uso continuo de o el acceso a nuestro sitio Web o el Servicio después de la publicación de cualquier cambio en estas Condiciones de servicio implica la aceptación de dichos cambios.\n\nTambién es posible que, en el futuro, te ofrezcamos nuevos servicios y/o características a través del sitio web (incluyendo el lanzamiento de nuevas herramientas y recursos). Estas nuevas características y/o servicios también estarán sujetos a estos Términos de Servicio.'),
                SizedBox(height: 20.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Text condicion(String data) {
    return Text(
      data,
      textAlign: TextAlign.justify,
      style: TextStyle(fontSize: 17.sp),
    );
  }

  Text title(String data) => Text(
        data,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.sp),
      );
}
