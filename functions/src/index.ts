import * as functions from "firebase-functions";

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
 export const helloWorld = functions.https.onCall((data, context) => {
   functions.logger.info("onCall!", {structuredData: true});
    return {data: "Hello from Cloud Functions!!!"};
 });
