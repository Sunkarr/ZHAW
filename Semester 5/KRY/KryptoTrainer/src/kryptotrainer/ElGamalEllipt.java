package kryptotrainer;

import mybiginteger.*;


public class ElGamalEllipt {
	
	
	  BigInteger p;   //Primzahl für GF(p)
	  
	  BigInteger a,b;  //Parameter für die elliptische Kurve (y^2 = x^3 + ax + b)
	  
	  BigInteger[] P = {BigInteger.ZERO, BigInteger.ZERO};  //ausgewählter Punkt (x,y) der elliptischen Kurve
	  
	  BigInteger kA, kB; //geheimer Schlüssel von Alice resp. von Bob
	  
	  BigInteger[] A =  {BigInteger.ZERO, BigInteger.ZERO};  //oeffentlicher Schluessel von Alice 
	  

	  /************************************************************************
	   ************************************************************************
	   * Methoden, die ausprogrammiert werden müssen.
	   ************************************************************************
	   ************************************************************************/
	  
	  
	    /**
	     * Berechnet die Verschlüsselung fuer eine Nachricht M, die als Punkt auf der elliptischen Kurve gegeben ist.
	     * @throws Exception 
	     */
	    
	    public BigInteger[] elliptEncrypt(BigInteger[] M) throws Exception 
	    {
		      BigInteger[] B = {BigInteger.ZERO, BigInteger.ZERO};
		      BigInteger[] C = {BigInteger.ZERO, BigInteger.ZERO};
		
		      
		      BigInteger result[] = {B[0], B[1], C[0], C[1]};
		      return result;
	    }
	    
	    
	    /**
	     * Berechnet die Entschlüsselung für die Nachricht (B,C) mithilfe von k_A.
	     * @throws Exception 
	     */
	    
	    public BigInteger[] elliptDecrypt(BigInteger[] B, BigInteger[] C) throws Exception 
	    
	    {
	    	BigInteger[] result = {BigInteger.ZERO, BigInteger.ZERO};

	    	
	    	return result;
	    }
	    
	    
	    /**
	     * Bestimmt zuerst eine Repräsentation der gegebenen Nachricht m als Punkt auf der elliptischen Kurve und berechnet dann die zugehörige Verschlüsselung
	     * @throws Exception 
	     */
	    
	    
	    public BigInteger[] messageEncrypt(BigInteger m) throws Exception
	    {
	    	BigInteger result[]  = {BigInteger.ZERO, BigInteger.ZERO};

	    	
	    	return result;
	    }
	    
	    
	    /**
	     * Bestimmt den durch das Chiffrat (B,C) verschlüsselten Punkt auf der Kurve und berechnet daraus die (durch eine Zahl repräsentierte) versendete Nachricht.
	     * @throws Exception 
	     */
	    
	    
	    
	    public BigInteger messageDecrypt(BigInteger[] B, BigInteger[] C) throws Exception
	    {
	    	BigInteger result = BigInteger.ZERO;

	    	
	    	return result;
	    	
	    }
	 


	  /************************************************************************
	   ************************************************************************
	   * Methoden, die fertig vorgegeben sind.
	   ************************************************************************
	   ************************************************************************/

	  public ElGamalEllipt() {
	  }

	  public void setPrimeNumber(BigInteger prime) {
	    p = prime;
	  }
	  
	  public void setParam_a(BigInteger param_a)
	  {
		  a = param_a;
	  }
	  
	  public void setParam_b(BigInteger param_b)
	  {
		  b = param_b;
	  }
	  
	  public void setP(BigInteger[] point)
	  {
		  P[0] = point[0];
		  P[1] = point[1];
	  }
	  
	  public void setKeyAlice(BigInteger keyAlice) throws Exception 
	  {
		  kA = keyAlice;
		  A = P[0].elliptMultiply(P[1], kA, p, a, b);
	  }
	  
	  public void setKeyBob(BigInteger keyBob)
	  {
		  kB = keyBob;
	  }
	  
	}
