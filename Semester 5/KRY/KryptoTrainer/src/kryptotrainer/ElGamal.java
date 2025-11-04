package kryptotrainer;

import mybiginteger.*;

/**
 * <p>Title: KryptoTrainer</p>
 * <p>Description: Übungsumgebung für das Wahlfach Kryptologie</p>
 * <p>Copyright: Copyright (c) 2006 / Samuel Beer</p>
 * <p>Company: Zürcher Hochschule Winterthur</p>
 * @author Samuel Beer
 * @version 1.0
 */

public class ElGamal {

  int bitLengthPublicKey;          // Länge der Primzahl p in Bits

  BigInteger[] publicKeyAlice;     // Öffentlicher Schlüssel (p,g,A) von Alice

  BigInteger privateKeyAlice;      // Privater Schlüssel a von Alice

  BigInteger plainText;            // Klartext Bob -> Alice

  BigInteger[] cipheredText;       // Chiffrat (B,c) Bob -> Alice

  BigInteger decipheredText;       // Dechiffrierter Text Bob -> Alice


  /************************************************************************
   ************************************************************************
   * Methoden, die ausprogrammiert werden müssen.
   ************************************************************************
   ************************************************************************/

  /**
   * Öffentlichen Schlüssel (p,g,A) und privaten Schlüssel (a) für Alice
   * generieren und in publicKeyAlice bzw. privateKeyAlice speichern.
   */
  public void generateKeyPair() {
      BigInteger p = BigInteger.probablePrime(bitLengthPublicKey, new java.util.Random());
      // initialisiere g, von 2 bis p-2
        java.util.Random rnd = new java.util.Random();
        BigInteger min = BigInteger.valueOf(2);
        BigInteger max = p.subtract(BigInteger.valueOf(2));
        BigInteger range = max.subtract(min).add(BigInteger.valueOf(1)); // range = p-3

        BigInteger g;
        if (range.signum() <= 0) {
          // fallback for very small p
          g = min;
        } else {
          do {
            g = new BigInteger(p.bitLength(), rnd).mod(range).add(min);
          } while (g.compareTo(min) < 0 || g.compareTo(max) > 0);
        }
        // generiere privaten Schlüssel a, 1 < a < p-2
        BigInteger a = BigInteger.probablePrime(bitLengthPublicKey - 2, new java.util.Random());
        // berechne öffentlichen Schlüssel A = g^a mod p
        BigInteger A = g.modPow(a, p);


    publicKeyAlice = new BigInteger[] {p, g, A};
    privateKeyAlice = a;
  }

  /**
   * Chiffrat (B,c) Bob -> Alice erstellen und in cipheredText abspeichern.
   */
  public void createCipheredText() {
      // Bob wählt b aus Zp*
      BigInteger b = BigInteger.probablePrime(bitLengthPublicKey - 2, new java.util.Random());
      BigInteger p = publicKeyAlice[0];
      BigInteger g = publicKeyAlice[1];
      BigInteger A = publicKeyAlice[2];
        // berechne B = g^b mod p
        BigInteger B = g.modPow(b, p);
        // berechne c = m * A^b mod p
        BigInteger c = plainText.multiply(A.modPow(b, p)).mod(p);

    cipheredText = new BigInteger[] {B, c};
  }

  /**
   * Dechiffrierten Text Bob -> Alice erstellen und in decipheredText abspeichern.
   */
  public void createDecipheredText() {
      BigInteger c = cipheredText[1];
        BigInteger B = cipheredText[0];
        BigInteger p = publicKeyAlice[0];

        BigInteger m = c.multiply(B.modPow(privateKeyAlice.negate().add(p.subtract(BigInteger.ONE)), p)).mod(p);
    decipheredText = m;
  }


  /************************************************************************
   ************************************************************************
   * Methoden, die fertig vorgegeben sind.
   ************************************************************************
   ************************************************************************/

  public ElGamal() {
  }

  public void setBitLength(int len) {
    bitLengthPublicKey = len;
  }

  public void setPlainText(BigInteger plain) {
    plainText = plain;
  }

  public BigInteger[] getCipheredText() {
    return cipheredText;
  }

  public BigInteger getDecipheredText() {
    return decipheredText;
  }

  public BigInteger[] getPublicKey() {
    return publicKeyAlice;
  }

  public BigInteger getPrivateKey() {
    return privateKeyAlice;
  }
}
