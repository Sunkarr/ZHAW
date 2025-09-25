package kryptotrainer;
import java.lang.*;
import java.util.Random;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import mybiginteger.*;

/**
 * <p>Title: KryptoTrainer</p>
 * <p>Description: Übungsumgebung für das Wahlfach Kryptologie</p>
 * <p>Copyright: Copyright (c) 2006 / Samuel Beer</p>
 * <p>Company: Zürcher Hochschule Winterthur</p>
 * @author Samuel Beer
 * @version 1.0
 */

public class FrameSerie10
    extends JFrame {
// Elemente des Frames
  JPanel contentPane;
  GridLayout gridLayoutContentPane = new GridLayout();
  JMenuBar jMenuBar1 = new JMenuBar();
  JPanel jPanel1 = new JPanel();
  JPanel jPanel2 = new JPanel();

// Elemente der MenuBar
  JMenu jMenuDatei = new JMenu();
  JMenuItem jMenuDateiSchliessen = new JMenuItem();

// Elemente jPanel1
  JButton jButtonStartA = new JButton();
  JLabel jLabelTitel = new JLabel();
  JLabel jLabelUntertitelA = new JLabel();
  JLabel jLabelUntertitelB = new JLabel();
  JLabel jLabelEingabeWert1 = new JLabel();
  JLabel jLabelEingabeMod1 = new JLabel();
  JLabel jLabelAusgabe1 = new JLabel();
  JLabel jLabelTest1 = new JLabel();
  JTextField jTextFieldEingabeWert1 = new JTextField();
  JTextField jTextFieldEingabeMod1 = new JTextField();
  JTextPane jTextPaneAusgabe1 = new JTextPane();
  JTextPane jTextPaneTest1 = new JTextPane();

// Elemente jPanel2
  JButton jButtonStartC = new JButton();
  JLabel jLabelUntertitelC = new JLabel();
  JLabel jLabelUntertitelD = new JLabel();
  JLabel jLabelEingabeWert2 = new JLabel();
  JLabel jLabelEingabeMod2 = new JLabel();
  JLabel jLabelAusgabe2 = new JLabel();
  JLabel jLabelTest2 = new JLabel();
  JTextPane jTextPaneEingabeWert2 = new JTextPane();
  JTextPane jTextPaneEingabeMod2 = new JTextPane();
  JTextPane jTextPaneAusgabe2 = new JTextPane();
  JTextPane jTextPaneTest2 = new JTextPane();

// Klassenvariablen
  private BigInteger eingabeWert1 = new BigInteger("1");
  private BigInteger eingabeMod1 = new BigInteger("1");
  private BigInteger ausgabeWert1 = new BigInteger("1");
  private BigInteger test1 = new BigInteger("1");
  private BigInteger eingabeWert2 = new BigInteger("1");
  private BigInteger eingabeMod2 = new BigInteger("1");
  private BigInteger ausgabeWert2 = new BigInteger("1");
  private BigInteger test2 = new BigInteger("1");
  private final static int bitLength = 256;


  public FrameSerie10() {
    try {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
// Allgemeine Initialisierungen
    this.setSize(new Dimension(650, 650));
    this.setTitle("KryptoTrainer Testumgebung zum Praktikum 12.1");

// Menu
    jMenuDatei.setText("Datei");
    jMenuDateiSchliessen.setText("Schliessen");
    jMenuDateiSchliessen.addActionListener(new
                                           FrameSerie10_jMenuDateiSchliessen_actionAdapter(this));

    jMenuDatei.add(jMenuDateiSchliessen);

    jMenuBar1.add(jMenuDatei);
    this.setJMenuBar(jMenuBar1);

// Panel 1
    jPanel1.setLayout(null);
    jPanel1.setBackground(Color.white);
    jButtonStartA.setText("Start");
    jButtonStartA.setBounds(new Rectangle(500, 127, 62, 25));
    jButtonStartA.addActionListener(new FrameSerie10_jButtonStartA_actionAdapter(this));
    jLabelTitel.setFont(new java.awt.Font("Times New Roman", 1, 19));
    jLabelTitel.setHorizontalAlignment(SwingConstants.LEFT);
    jLabelTitel.setHorizontalTextPosition(SwingConstants.LEADING);
    jLabelTitel.setText("Testumgebung zur Methode myModSqrt()");
    jLabelTitel.setBounds(new Rectangle(1, 1, 564, 23));
    jLabelUntertitelA.setText("a) Testberechnungen (manuelle Eingabe)");
    jLabelUntertitelA.setBounds(new Rectangle(9, 29, 305, 17));
    jLabelUntertitelA.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelEingabeWert1.setText("Eingabewert n");
    jLabelEingabeWert1.setBounds(new Rectangle(9, 48, 188, 15));
    jLabelEingabeMod1.setBounds(new Rectangle(9, 84, 188, 15));
    jLabelEingabeMod1.setText("Modulus p (Primzahl)");
    jLabelAusgabe1.setBounds(new Rectangle(9, 147, 196, 15));
    jLabelAusgabe1.setText("Ausgabewert myModSqrt()");
    jLabelUntertitelB.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelUntertitelB.setText("b) Test durch Zurückrechnen");
    jLabelUntertitelB.setBounds(new Rectangle(9, 197, 391, 17));
    jLabelTest1.setText("(Ausgabe^2 - n) mod p (sollte gleich Null sein)");
    jLabelTest1.setBounds(new Rectangle(9, 215, 332, 15));
    jTextFieldEingabeWert1.setBounds(new Rectangle(9, 63, 553, 21));
    jTextFieldEingabeWert1.setText(eingabeWert1.toString());
    jTextFieldEingabeWert1.addActionListener(new
                                      FrameSerie10_jTextFieldEingabeWert1_actionAdapter(this));
    jTextFieldEingabeWert1.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldEingabeWert1.setSelectionEnd(11);
    jTextFieldEingabeWert1.setNextFocusableComponent(null);
    jTextFieldEingabeMod1.setText(eingabeMod1.toString());
    jTextFieldEingabeMod1.setNextFocusableComponent(null);
    jTextFieldEingabeMod1.setSelectionEnd(11);
    jTextFieldEingabeMod1.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldEingabeMod1.addActionListener(new
                                      FrameSerie10_jTextFieldEingabeMod1_actionAdapter(this));
    jTextFieldEingabeMod1.setBounds(new Rectangle(9, 99, 553, 21));
    jTextPaneAusgabe1.setBounds(new Rectangle(9, 162, 553, 21));
    jTextPaneAusgabe1.setEditable(false);
    jTextPaneAusgabe1.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneAusgabe1.setBackground(Color.lightGray);
    jTextPaneTest1.setBackground(Color.lightGray);
    jTextPaneTest1.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneTest1.setEditable(false);
    jTextPaneTest1.setBounds(new Rectangle(9, 230, 553, 21));

    jPanel1.add(jLabelTitel, null);
    jPanel1.add(jLabelUntertitelA, null);
    jPanel1.add(jTextPaneAusgabe1, null);
    jPanel1.add(jButtonStartA, null);
    jPanel1.add(jLabelAusgabe1, null);
    jPanel1.add(jTextFieldEingabeWert1, null);
    jPanel1.add(jLabelEingabeWert1, null);
    jPanel1.add(jTextFieldEingabeMod1, null);
    jPanel1.add(jLabelEingabeMod1, null);
    jPanel1.add(jLabelUntertitelB, null);
    jPanel1.add(jTextPaneTest1, null);
    jPanel1.add(jLabelTest1, null);

// Panel 2
    jPanel2.setBackground(Color.white);
    jPanel2.setLayout(null);
    jButtonStartC.setText("Start");
    jButtonStartC.addActionListener(new FrameSerie10_jButtonStartC_actionAdapter(this));
    jButtonStartC.setBounds(new Rectangle(500, 37, 62, 25));
    jLabelUntertitelC.setText("c) Testberechnung (mit Zufallszahlen)");
    jLabelUntertitelC.setBounds(new Rectangle(9, 9, 314, 17));
    jLabelUntertitelC.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelUntertitelD.setBounds(new Rectangle(9, 177, 391, 17));
    jLabelUntertitelD.setText("d) Test durch Zurückrechnen");
    jLabelUntertitelD.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelEingabeWert2.setText("Zufallswert n");
    jLabelEingabeWert2.setBounds(new Rectangle(9, 55, 188, 15));
    jLabelEingabeMod2.setBounds(new Rectangle(9, 91, 188, 15));
    jLabelEingabeMod2.setText("Zufälliger Modulus p (Primzahl)");
    jLabelAusgabe2.setText("Ausgabewert myModSqrt()");
    jLabelAusgabe2.setBounds(new Rectangle(9, 127, 196, 15));
    jLabelTest2.setText("(Ausgabe^2 - n) mod p (sollte gleich Null sein)");
    jLabelTest2.setBounds(new Rectangle(9, 195, 332, 15));
    jTextPaneEingabeWert2.setBounds(new Rectangle(9, 70, 553, 21));
    jTextPaneEingabeWert2.setEditable(false);
    jTextPaneEingabeWert2.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneEingabeWert2.setBackground(Color.lightGray);
    jTextPaneEingabeMod2.setBounds(new Rectangle(9, 106, 553, 21));
    jTextPaneEingabeMod2.setEditable(false);
    jTextPaneEingabeMod2.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneEingabeMod2.setBackground(Color.lightGray);
    jTextPaneAusgabe2.setBackground(Color.lightGray);
    jTextPaneAusgabe2.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneAusgabe2.setEditable(false);
    jTextPaneAusgabe2.setBounds(new Rectangle(9, 142, 553, 21));
    jTextPaneTest2.setBounds(new Rectangle(9, 210, 553, 21));
    jTextPaneTest2.setEditable(false);
    jTextPaneTest2.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneTest2.setBackground(Color.lightGray);

    jPanel2.add(jTextPaneEingabeWert2, null);
    jPanel2.add(jLabelUntertitelC, null);
    jPanel2.add(jButtonStartC, null);
    jPanel2.add(jLabelEingabeWert2, null);
    jPanel2.add(jLabelEingabeMod2, null);
    jPanel2.add(jTextPaneEingabeMod2, null);
    jPanel2.add(jLabelAusgabe2, null);
    jPanel2.add(jTextPaneAusgabe2, null);
    jPanel2.add(jLabelUntertitelD, null);
    jPanel2.add(jLabelTest2, null);
    jPanel2.add(jTextPaneTest2, null);

// ContentPane
    contentPane = (JPanel)this.getContentPane();
    contentPane.setMinimumSize(new Dimension(600, 800));
    contentPane.setPreferredSize(new Dimension(600, 800));
    gridLayoutContentPane.setColumns(1);
    gridLayoutContentPane.setRows(2);
    contentPane.setLayout(gridLayoutContentPane);

    contentPane.add(jPanel1, null);
    contentPane.add(jPanel2, null);
  }

  void jButtonStartA_actionPerformed(ActionEvent e) {
    updateFields();

    // Testberechnungen
    eingabeWert1=eingabeWert1.mod(eingabeMod1);
    ausgabeWert1 = eingabeWert1.myModSqrt(eingabeMod1);
    test1 = (ausgabeWert1.modPow(new BigInteger("2"), eingabeMod1)).subtract(eingabeWert1);

    // Ausgabe
    if (ausgabeWert1.equals(BigInteger.valueOf(-1))) {
      jTextPaneAusgabe1.setText("Keine Lösung!");
      jTextPaneTest1.setText("");
    }
    else {
      jTextPaneAusgabe1.setText(ausgabeWert1.toString());
      jTextPaneTest1.setText(test1.toString());
    }
  }

  void jButtonStartC_actionPerformed(ActionEvent e) {
    updateFields();

    // Zufallszahlen genenrieren und anzeigen
    Random rnd = new Random();
    eingabeWert2 = new BigInteger(bitLength, rnd);
    eingabeMod2 = new BigInteger(bitLength+3, 8, rnd);
    eingabeWert2 = eingabeWert2.mod(eingabeMod2);
    jTextPaneEingabeWert2.setText(eingabeWert2.toString());
    jTextPaneEingabeMod2.setText(eingabeMod2.toString());

    // Testberechnungen
    ausgabeWert2 = eingabeWert2.myModSqrt(eingabeMod2);
    test2 = (ausgabeWert2.modPow(new BigInteger("2"), eingabeMod2)).subtract(eingabeWert2);

    // Ausgabe
    if (ausgabeWert2.equals(BigInteger.valueOf(-1))) {
      jTextPaneAusgabe2.setText("Keine Lösung!");
      jTextPaneTest2.setText("");
    }
    else {
      jTextPaneAusgabe2.setText(ausgabeWert2.toString());
      jTextPaneTest2.setText(test2.toString());
    }
  }

  void jMenuDateiSchliessen_actionPerformed(ActionEvent e) {
    this.dispose();
  }

  void jTextFieldEingabeWert1_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldEingabeWert1.selectAll();
  }

  void jTextFieldEingabeMod1_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldEingabeMod1.selectAll();
  }

  void updateFields() {
    eingabeWert1 = new BigInteger(jTextFieldEingabeWert1.getText());
    eingabeMod1 = new BigInteger(jTextFieldEingabeMod1.getText());
  }
}

class FrameSerie10_jMenuDateiSchliessen_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie10 adaptee;

  FrameSerie10_jMenuDateiSchliessen_actionAdapter(FrameSerie10 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuDateiSchliessen_actionPerformed(e);
  }
}

class FrameSerie10_jButtonStartA_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie10 adaptee;

  FrameSerie10_jButtonStartA_actionAdapter(FrameSerie10 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartA_actionPerformed(e);
  }
}

class FrameSerie10_jTextFieldEingabeWert1_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie10 adaptee;

  FrameSerie10_jTextFieldEingabeWert1_actionAdapter(FrameSerie10 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldEingabeWert1_actionPerformed(e);
  }
}

class FrameSerie10_jTextFieldEingabeMod1_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie10 adaptee;

  FrameSerie10_jTextFieldEingabeMod1_actionAdapter(FrameSerie10 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldEingabeMod1_actionPerformed(e);
  }
}

class FrameSerie10_jButtonStartC_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie10 adaptee;

  FrameSerie10_jButtonStartC_actionAdapter(FrameSerie10 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartC_actionPerformed(e);
  }
}
