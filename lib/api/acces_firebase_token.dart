import 'package:googleapis_auth/auth_io.dart';

class AccessFirebaseToken {
  static String fMessagingScope =
      "https://www.googleapis.com/auth/firebase.messaging";

  Future<String> getAccessToken() async {
    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "gas-master",
        "private_key_id": "259b1f6500e496c662ec3a3c147ec191a1314189",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCzXIFj++sQYDSv\nziL20p3AJDzTs7vXiPe6Z+FpGaGUWONYUmauqZZ3VSh80Uz/HFn+Gh2oA0Z/xtpP\nv+nUZv0S7BKIwSQ9wcr7UnsLklVEn/ggP1Vc+frqJgIL6NobeYsYE8iEd9+n4Daj\nshu+2ZM8TV+R4/FuIuRzWGJkTvSXS/veh970Zpn8BrMCGScxTWknPL2JUZW6XDkx\n1oOs+49ie3A0uCaZMZd+7k61A+EVzKucOrH1cjp0r0CAnB1RMdOPUR2IBEiLAdqr\nKSXXzp1EQWaV/aZzdmmwOkBBCmDi9UMlmAkAmjqb93IIr1r6Nw7fsWmKHy1XI+v7\n9c0c4ApVAgMBAAECggEACvLUISbREARXYv3py3hK0d5EakXX6w281X+e1lwOrXAJ\nnKwXAYVvnmQv3wKluRLheW3drpJYnNcmH2UfIGyS+TM45Gkpza1FNzcvNKMfmltL\neah0DQNjaiSczl5N5gxyzarzfAaXO/enTjHCmNFOOAmfElhANhFiMZpNE0NwkcWi\n809qhFwfetLevSESVr4f90ubH9vNWQVsCPiOUGbyBrbcz5DC/I50jdjVjk/PQeC9\nMI8iJiSCrOpHWmTY3QPD+/sivLKs6lXZiiy7xXwVAdz4kqG63uP+OyowWv6ckx5b\n+PkJiZWBRWKSgbUOBebCgOw0VuguuicUBK0mBmfpIQKBgQDdMMZD4KJAvxsDwuQm\ntxoIIrF6K5Keu+Sky+Lo+zRUE/4x6gE/CemlT2LFLG1MWfN3D3gvpKrkv6MfbxWg\n2d/s2lH5bFHW9yelybL9/fP4XrRT9mA5caYAVlmyNfVU2eeADxMcT6dS6xCgcfOF\n6n6kZuyvME/c4oiQeGdcoUw6kQKBgQDPlokk1Zb9D5eH9LNS+ZQ/3//9XHiHRnkM\nQxokJuYk9pJDWhFiybWfCm/VvRotFjSU3uekoSylUWouJM5dX/RggADrOt3jERFX\n+o+Yjxa7rmxgfsSGVxeYR3Pc9zb9hsUwdgbT4vS0wqtgh2+KAGh++DH6PV0tC+V7\nNKTCfChNhQKBgCqpHZQ53xFdyngPPrG43uxyxIgrnzu+QXsHV9xXluAgewZle5gM\n8WNQzFv7FZmEP9DWyvdlaxBzZaLKagF8BBRKh0Tz/1TWlm8DV+Jk+IkOuvj2q9ho\ncvvdq68TeR3EaUHppmXvdvYnIC3RzIYnlAVhVIT1bHHNv0kd79GNyoYBAoGAQKYH\nC/ugzCrg7Cxe9IZZjxL5rDPyLV7bL+Bt8bhTkEth/au9ImDjOSaM8am0zznNIlfR\nGEpBlzKluL0pr5bEipESuC9bDu4v0pBry/0z/Tsy8VJJbfUNmhUWlkg/TfF807zO\nH4rc3raJnMRRDk9WO8Sb++zEadT8oMQiU5dLDekCgYBKNWXrbTyb4nryye6/BRX7\njGVMWgboTOkolI3muNz/r84Rl5I1shGSE1IV5K0DEXqQJF9P3oA5eDZ+xp6DyF1b\n0VxG7tdqWKeo65QLxMzyZXhdSch8gq9Vo7tlRc1so7wllqLhBGXt++qpA7uDgGK6\nf54WeYonghVguv7qGy0T2A==\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-wea6g@gas-master.iam.gserviceaccount.com",
        "client_id": "106587170742025973660",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-wea6g%40gas-master.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }),
      [fMessagingScope],
    );

    final accessToken = client.credentials.accessToken.data;
    return accessToken;
  }
}
