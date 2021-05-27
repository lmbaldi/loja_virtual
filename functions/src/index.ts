/* eslint-disable object-curly-spacing */
/* eslint-disable max-len */
/* eslint-disable eol-last */
/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable space-before-blocks */
import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { CieloConstructor, Cielo, TransactionCreditCardRequestModel, CaptureRequestModel, CancelTransactionRequestModel, EnumBrands } from "cielo";

admin.initializeApp(functions.config().firebase);

const merchantId = functions.config().cielo.merchantId;
const merchantKey = functions.config().cielo.merchantKey;

const cieloParams: CieloConstructor = {
  merchantId: merchantId,
  merchantKey: merchantKey,
  sandbox: true, // Opcional - Ambiente de Testes
  debug: true, // Opcional - Exibe os dados enviados na requisição para a Cielo
};

const cielo = new Cielo(cieloParams);


export const authorizeCreditCard = functions.https.onCall(async (data, context) => {
  if (data === null) {
    return {
      "success": false,
      "error": {
        "code": -1,
        "message": "Dados não informados",
      },
    };
  }

  if (!context.auth) {
    return {
      "success": false,
      "error": {
        "code": -1,
        "message": "Nenhum usuario logado",
      },
    };
  }

  const userId = context.auth.uid;
  const snapshot = await admin.firestore().collection("users").doc(userId).get();
  const userData = snapshot.data;
  console.log("Inciando autorizacao");

  let brand: EnumBrands;
  switch (data.creditCard.brand) {
    case "VISA":
      brand = EnumBrands.VISA;
      break;
    case "MASTERCARD":
      brand = EnumBrands.MASTER;
      break;
    case "AMEX":
      brand = EnumBrands.AMEX;
      break;
    case "ELO":
      brand = EnumBrands.ELO;
      break;
    case "JCB":
      brand = EnumBrands.JCB;
      break;
    case "DINERSCLUB":
      brand = EnumBrands.DINERS;
      break;
    case "DISCOVER":
      brand = EnumBrands.DISCOVERY;
      break;
    case "HIPERCARD":
      brand = EnumBrands.HIPERCARD;
      break;
    default:
      return {
        "success": false,
        "error": {
          "code": -1,
          "message": "Cartão não suportado: " + data.creditCard.brand,
        },
      };
    }
  });

export const helloWorld = functions.https.onCall((data, context) => {
  functions.logger.info("onCall!", { structuredData: true });
  return { data: "Hello from Cloud Functions!!!" };
});

export const getUserData = functions.https.onCall(async (data, context) => {
  // eslint-disable-next-line space-before-blocks
  // eslint-disable-next-line keyword-spacing
  if (!context.auth) {
    return { "data": "Nenhum usuario logado" };
  }

  const snapshot = await admin.firestore()
    .collection("users")
    .doc(context.auth.uid).get();

  console.log(snapshot.data());

  return { data: snapshot.data() };
});


export const addMessage = functions.https.onCall(async (data, context) => {
  console.log(data);
  // adicionar um documento no firestore
  const snapshot = await admin.firestore().collection("messages").add(data);

  return { "success": snapshot.id };
  // eslint-disable-next-line eol-last
});

export const onNewOrder = functions.firestore.document("/orders/{orderId}")
  .onCreate((snapshot, context) => {
    const orderId = context.params.orderId;
    console.log(orderId);
  });