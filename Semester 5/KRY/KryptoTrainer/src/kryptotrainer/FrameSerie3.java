package kryptotrainer;

import javax.swing.*;

import java.awt.*;
import java.awt.event.*;
import java.util.Random;

import mybiginteger.*;

/**
 * <p>Title: KryptoTrainer</p>
 * <p>Description: Übungsumgebung für das Wahlfach Kryptologie</p>
 * <p>Copyright: Copyright (c) 2006 / Samuel Beer</p>
 * <p>Company: Zürcher Hochschule Winterthur</p>
 * <p>Version 1.1: Umgeschrieben für Array Benutzung
 * @author Samuel Beer
 * @version 1.1
 */

/**
 * Programmierschnittstelle
 * ========================
 *
 * Variabeln:
 * ----------
 *
 *    datenSatzUnverschl[5]:
 *           BigInteger-Variabeln, welche die unverschlüsselten Datensätze F_i enthalten.
 *
 *    schluessel[5]:
 *           BigInteger-Variabeln, welche die Read-Keys p_i der einzelnen Benutzer enthalten.
 *
 *    datenbankVerschl:
 *           BigInteger-Variable, welche die gesamte verschlüsselte Datenbank E entält.
 *
 *    datenSatzEntschl[5]:
 *           BigInteger-Variabeln, welche die entschlüsselten Datensätze F_i enthalten.
 *
 *
 * Methoden die fertig zur Verügung stehen:
 * ----------------------------------------
 *
 *    private void schluesselAnzeigen()
 *           Zeigt die Werte der Variabeln schluessel[0...4] in den entsprechenden
 *           Textfeldern an.
 *
 *    private void datenbankVerschlAnzeigen()
 *           Zeigt die Variable datenbankVerschl im entsprechenden
 *           Textfeld an.
 *
 *    private void datenSatzEntschlAnzeigen()
 *           Zeigt die Werte der Variabeln datenSatzEntschl[0...4]
 *           in den entsprechenden Textfeldern an.
 *
 *
 * Methoden die ausprogrammiert werden müssen (nur Stubs vorhanden):
 * -----------------------------------------------------------------
 *
 *    private void doDatenbankVerschl(void)
 *           Erstellt die Read-Keys, verschlüsselt damit die
 *           Datenbank und zeigt die Read-Keys sowie die verschlüsselte
 *           Datenbank an.
 *
 *    private void doDatenbankEntschl(void)
 *           Berechnet mithilfe der Read-Keys aus der verschlüsselten Datenbank
 *           die einzelnen Datensätze und zeigt diese an.
 *
 */

public class FrameSerie3 extends JFrame implements ActionListener{

  private static final long serialVersionUID = 1L;
// Elemente des Frames
  JPanel contentPane;
  GridLayout gridLayoutContentPane = new GridLayout();
  JMenuBar jMenuBar1 = new JMenuBar();
  JPanel jPanel1 = new JPanel();  
  JPanel jPanel2 = new JPanel();  
  JPanel jPanel3 = new JPanel();

// Elemente der MenuBar
  JMenu jMenuDatei = new JMenu();
  JMenuItem jMenuDateiSchliessen = new JMenuItem();
  
// Elemente jPanel1
  JLabel jLabelTitel = new JLabel();
  JLabel jLabelUntertitelA = new JLabel();
  JLabel[] jLabelDatenSatz = new JLabel[5];
  JTextField[] jTextFieldDatenSatz = new JTextField[5];

// Elemente jPanel2
  JButton jButtonVerschl = new JButton();
  JLabel jLabelUntertitelB = new JLabel();
  JLabel[] jLabelSchluessel = new JLabel[5];
  JLabel jLabelVerschlDB = new JLabel();
  JTextArea[] jTextAreaSchluessel = new JTextArea[5];
  JTextArea jTextAreaVerschlDB = new JTextArea();

// Elemente jPanel3
  JButton jButtonEntschl = new JButton();
  JLabel jLabelUntertitelC = new JLabel();
  JLabel[] jLabelEntschl = new JLabel[5];
  JTextArea[] jTextAreaEntschl = new JTextArea[5];

// Variabeln, die zur Programmierschnittstelle gehören
  BigInteger[] datenSatzUnverschl = new BigInteger[5];
  BigInteger[] schluessel = new BigInteger[5];
  BigInteger datenbankVerschl = new BigInteger("0");
  BigInteger[] datenSatzEntschl = new BigInteger[5];

  public FrameSerie3() {
	for(int i = 0; i< 5; i++){
		jLabelDatenSatz[i]= new JLabel();
		jTextFieldDatenSatz[i] = new JTextField();
		jLabelSchluessel[i] = new JLabel();
		jTextAreaSchluessel[i] = new JTextArea();
		jLabelEntschl[i] = new JLabel();
		jTextAreaEntschl[i] = new JTextArea();
		datenSatzUnverschl[i] = new BigInteger("0");
		schluessel[i]  = new BigInteger("0");
		datenSatzEntschl[i] = new BigInteger("0");
	}
    try {
      jbInit();
    }
    catch(Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
// Allgemeine Initialisierungen
    this.setSize(new Dimension(600, 800));
    this.setTitle("KryptoTrainer Testumgebung zum Praktikum 4.2");

// Menu
    jMenuDatei.setText("Datei");
    jMenuDateiSchliessen.setText("Schliessen");
    jMenuDateiSchliessen.addActionListener(this);	
    jMenuDatei.add(jMenuDateiSchliessen);
    jMenuBar1.add(jMenuDatei);
    this.setJMenuBar(jMenuBar1);

// Schriftart und Grösse für JTextArea Felder
    Font font = new Font(Font.MONOSPACED, Font.PLAIN, 13);
    
// Panel 1
    jPanel1.setLayout(null);
    jPanel1.setBackground(Color.white);
    jLabelTitel.setFont(new java.awt.Font("Times New Roman", 1, 19));
    jLabelTitel.setHorizontalAlignment(SwingConstants.LEFT);
    jLabelTitel.setHorizontalTextPosition(SwingConstants.LEADING);
    jLabelTitel.setText("Datenbankverschlüsselung mit Chin. Restsatz");
    jLabelTitel.setBounds(new Rectangle(1, 1, 564, 23));
    jLabelUntertitelA.setText("Unverschlüsselte Datensätze");
    jLabelUntertitelA.setBounds(new Rectangle(9, 33, 255, 17));
    jLabelUntertitelA.setFont(new java.awt.Font("Times New Roman", 1, 15));
    
    int[] recYLabelDatenSatz = {61, 85, 110, 134,158};
    int[] recYTextFieldDatenSatz = {58, 82, 107, 131,155};
    for (int i=0; i<5; i++) {
    	jLabelDatenSatz[i].setText("Datensatz "+(i+1));
        jLabelDatenSatz[i].setBounds(new Rectangle(385, recYLabelDatenSatz[i], 133, 15));
        
        jTextFieldDatenSatz[i].setBounds(new Rectangle(9, recYTextFieldDatenSatz[i], 373, 21));
        jTextFieldDatenSatz[i].setHorizontalAlignment(SwingConstants.RIGHT);
        jTextFieldDatenSatz[i].setSelectionEnd(11);
        jTextFieldDatenSatz[i].setText("0");
        jTextFieldDatenSatz[i].addActionListener(this);
    }
    
    jPanel1.add(jLabelTitel, null);
    jPanel1.add(jLabelUntertitelA, null);
    for (int i=0; i<5; i++) {
    	jPanel1.add(jLabelDatenSatz[i], null);
    	jPanel1.add(jTextFieldDatenSatz[i], null);
    }    


// Panel 2
    jPanel2.setLayout(null);
    jPanel2.setBackground(Color.white);
    jButtonVerschl.setBounds(new Rectangle(114, 23, 147, 25));
    jButtonVerschl.setText("Verschlüsseln");
    jButtonVerschl.addActionListener(this);
    jLabelUntertitelB.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelUntertitelB.setText("Verschlüsselung der Datenbank");
    jLabelUntertitelB.setBounds(new Rectangle(9, 3, 255, 17));
    int[] recYLabelSchluessel = {58, 80, 102, 124, 146};
    for (int i=0; i<5; i++) {
    	jLabelSchluessel[i].setText("Schlüssel "+(i+1));
        jLabelSchluessel[i].setBounds(new Rectangle(383, recYLabelSchluessel[i], 145, 15));
    }

    jLabelVerschlDB.setText("Verschlüsselte Datenbank");
    jLabelVerschlDB.setBounds(new Rectangle(383, 199, 181, 15));
    int[] recYTextAreaSchluessel = {55, 77, 99, 121, 143};
    for (int i=0; i<5; i++) {
	    jTextAreaSchluessel[i].setBounds(new Rectangle(9, recYTextAreaSchluessel[i], 370, 21));
	    jTextAreaSchluessel[i].setText("");
	    jTextAreaSchluessel[i].setEditable(false);
	    jTextAreaSchluessel[i].setBackground(Color.lightGray);
	    jTextAreaSchluessel[i].setFont(font);
    }

    jTextAreaVerschlDB.setBounds(new Rectangle(9, 165, 370, 83));
    jTextAreaVerschlDB.setText("");
    jTextAreaVerschlDB.setEditable(false);
    jTextAreaVerschlDB.setBackground(Color.lightGray);
    jTextAreaVerschlDB.setFont(font);
    jTextAreaVerschlDB.setLineWrap(true);

    jPanel2.add(jButtonVerschl, null);
    jPanel2.add(jLabelUntertitelB, null);
    for (int i=0; i<5; i++) {
    	jPanel2.add(jLabelSchluessel[i], null);
    	jPanel2.add(jTextAreaSchluessel[i], null);
    }
    jPanel2.add(jTextAreaVerschlDB, null);
    jPanel2.add(jLabelVerschlDB, null);

// Panel 3
    jPanel3.setLayout(null);
    jPanel3.setBackground(Color.white);
    jPanel3.setOpaque(true);
    jButtonEntschl.setText("Entschlüsseln");
    jButtonEntschl.setBounds(new Rectangle(114, 40, 147, 25));
    jButtonEntschl.addActionListener(this);
    jPanel3.add(jButtonEntschl, null);
    jLabelUntertitelC.setText("Entschlüsseln der Datenbank");
    jLabelUntertitelC.setBounds(new Rectangle(8, 19, 270, 17));
    jLabelUntertitelC.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jPanel3.add(jLabelUntertitelC, null);
    
    int[] recYLabelEntschl = {80,102,124,146,168};
    int[] recYTextAreaEntschl = {77,99,121,143,165};
    for (int i=0; i<5; i++) {
    	jLabelEntschl[i].setText("Entschlüsselter Datensatz "+(i+1));
        jLabelEntschl[i].setBounds(new Rectangle(383, recYLabelEntschl[i], 192, 15));
        jPanel3.add(jLabelEntschl[i], null);
        
        jTextAreaEntschl[i].setBackground(Color.lightGray);
        jTextAreaEntschl[i].setEditable(false);
        jTextAreaEntschl[i].setText("");
        jTextAreaEntschl[i].setBounds(new Rectangle(9, recYTextAreaEntschl[i], 370, 21));
        jTextAreaEntschl[i].setFont(font);
        
        jPanel3.add(jTextAreaEntschl[i], null);
    }

// ContentPane
    contentPane = (JPanel) this.getContentPane();
    contentPane.setMinimumSize(new Dimension(600, 800));
    contentPane.setPreferredSize(new Dimension(600, 800));
    gridLayoutContentPane.setColumns(1);
    gridLayoutContentPane.setRows(3);
    contentPane.setLayout(gridLayoutContentPane);

    contentPane.add(jPanel1, null);
    contentPane.add(jPanel2, null);
    contentPane.add(jPanel3, null);
  }

  private void schluesselAnzeigen() {
  	for (int i=0; i<5; i++) {
  		jTextAreaSchluessel[i].setText(schluessel[i].toString());
	}
  }

  private void datenbankVerschlAnzeigen() {
    jTextAreaVerschlDB.setText(datenbankVerschl.toString());
  }

  private void datenSatzEntschlAnzeigen() {
  	for (int i=0; i<5; i++) {
  		jTextAreaEntschl[i].setText(datenSatzEntschl[i].toString());
  	}
  }

  /**
   * Diese Methode muss ausprogrammiert werden!
   */
  private void doDatenbankVerschl() {
      /*
       * Schluessel erzeugen
       * Konstruktion von 5 paarweise teilerfremden Primzahlen p_i
       */

      schluessel[0] = BigInteger.probablePrime(256, new Random());
      schluessel[1] = BigInteger.probablePrime(256, new Random());
      schluessel[2] = BigInteger.probablePrime(256, new Random());
      schluessel[3] = BigInteger.probablePrime(256, new Random());
      schluessel[4] = BigInteger.probablePrime(256, new Random());


    // Datenbank verschlüsseln
      // Berechne m als Produkt aller Schlüssel
      BigInteger m = BigInteger.ONE;
      for (int i = 0; i < schluessel.length; i++) {
          m = m.multiply(schluessel[i]);
      }

      // Berechne M[i] und u[i] für jeden Index
      BigInteger[] M = new BigInteger[schluessel.length];
      BigInteger[] u = new BigInteger[schluessel.length];
      for (int i = 0; i < schluessel.length; i++) {
          M[i] = m.divide(schluessel[i]);
          u[i] = M[i].modInverse(schluessel[i]);
      }

      // Berechne datenbankVerschl
      datenbankVerschl = BigInteger.ZERO;
      for (int i = 0; i < datenSatzUnverschl.length; i++) {
          datenbankVerschl = datenbankVerschl.add(
                  datenSatzUnverschl[i].multiply(M[i]).multiply(u[i])
          );
      }
      datenbankVerschl = datenbankVerschl.mod(m);



 
    // Ergebnisse anzeigen
    schluesselAnzeigen();
    datenbankVerschlAnzeigen();
  }

  /**
   * Diese Methode muss ausprogrammiert werden!
   */
  private void doDatenbankEntschl() {
  	// Datenbank entschlüsseln
        // Berechne m als Produkt aller Schlüssel
        BigInteger m = BigInteger.ONE;
        for (int i = 0; i < schluessel.length; i++) {
            m = m.multiply(schluessel[i]);
        }

        // Berechne M[i] und u[i] für jeden Index
        BigInteger[] M = new BigInteger[schluessel.length];
        BigInteger[] u = new BigInteger[schluessel.length];
        for (int i = 0; i < schluessel.length; i++) {
            M[i] = m.divide(schluessel[i]);
            u[i] = M[i].modInverse(schluessel[i]);
        }

        // Berechne datenSatzEntschl
        for (int i = 0; i < datenSatzEntschl.length; i++) {
            datenSatzEntschl[i] = datenbankVerschl.mod(schluessel[i]);
        }

    // Ergebnisse anzeigen
    datenSatzEntschlAnzeigen();
  }
  
  public void actionPerformed( ActionEvent e ) {
  	if (e.getSource() == jMenuDateiSchliessen)
  		this.dispose();
  	else {
  		for (int i=0; i<5; i++) {
  			datenSatzUnverschl[i] = new BigInteger(jTextFieldDatenSatz[i].getText());
  		}
  		if (e.getSource() == jButtonVerschl)
  			doDatenbankVerschl();
  		else if (e.getSource() == jButtonEntschl)
  			doDatenbankEntschl();
	}
  }
}
