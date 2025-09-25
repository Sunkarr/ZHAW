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
 * @author Samuel Beer
 * @version 1.0
 */

public class FrameSerie4
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
  JLabel jLabelTitel1 = new JLabel();
  JButton jButtonStartA = new JButton();
  JButton jButtonStopA = new JButton();
  JLabel jLabelPrimTab = new JLabel();
  JLabel jLabelObergrenze = new JLabel();
  JList jListPrimTab = new JList();
  JScrollPane jScrollPanePrimTab = new JScrollPane();
  JTextField jTextFieldObergrenze = new JTextField();
  PrimZahlenBerechnen primZahlenBerechnen;
  int oberGrenze = 1;

// Elemente jPanel2
  JLabel jLabelTitel2 = new JLabel();
  JButton jButtonStartB = new JButton();
  JButton jButtonStopB = new JButton();
  JLabel jLabelAnzTests = new JLabel();
  JLabel jLabelBitLaenge = new JLabel();
  JLabel jLabelAnzGetestet = new JLabel();
  JLabel jLabelAnzFehlerAbs = new JLabel();
  JLabel jLabelAnzFehlerRel = new JLabel();
  JLabel jLabelObergrenzeKleineTeiler = new JLabel();
  JTextArea jTextAreaAnzGetestet = new JTextArea();
  JTextArea jTextAreaAnzFehlerAbs = new JTextArea();
  JTextArea jTextAreaAnzFehlerRel = new JTextArea();
  JTextField jTextFieldAnzTests = new JTextField();
  JTextField jTextFieldBitLaenge = new JTextField();
  JTextField jTextFieldObergrenzeKleineTeiler = new JTextField();
  FermatTest fermatTest;
  int bitLaenge = 16;
  int kleinePrim = 1;
  int anzTests = 1;

  public FrameSerie4() {
    try {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
// Allgemeine Initialisierungen
    this.setSize(new Dimension(600, 800));
    this.setTitle("KryptoTrainer Testumgebung zum Praktikum 6");

// Menu
    jMenuDatei.setText("Datei");
    jMenuDateiSchliessen.setText("Schliessen");
    jMenuDateiSchliessen.addActionListener(new
                                           FrameSerie4_jMenuDateiSchliessen_actionAdapter(this));

    jMenuDatei.add(jMenuDateiSchliessen);

    jMenuBar1.add(jMenuDatei);
    this.setJMenuBar(jMenuBar1);

// Schriftart und Grösse für JTextArea Felder
    Font font = new Font(Font.MONOSPACED, Font.PLAIN, 13);
    
// Panel 1
    jPanel1.setLayout(null);
    jPanel1.setBackground(Color.white);
    jButtonStartA.setBounds(new Rectangle(413, 117, 73, 25));
    jButtonStartA.setText("Start");
    jButtonStartA.addActionListener(new FrameSerie4_jButtonStartA_actionAdapter(this));
    jButtonStopA.setText("Stop");
    jButtonStopA.addActionListener(new FrameSerie4_jButtonStopA_actionAdapter(this));
    jButtonStopA.setBounds(new Rectangle(413, 152, 73, 25));
    jLabelTitel1.setFont(new java.awt.Font("Times New Roman", 1, 19));
    jLabelTitel1.setHorizontalAlignment(SwingConstants.LEFT);
    jLabelTitel1.setHorizontalTextPosition(SwingConstants.LEADING);
    jLabelTitel1.setText(
        "Testumgebung zur Primzahl-Tabelle");
    jLabelTitel1.setBounds(new Rectangle(1, 1, 564, 23));
    jLabelPrimTab.setBounds(new Rectangle(9, 34, 145, 15));
    jLabelPrimTab.setText("Tabelle der Primzahlen");
    jLabelObergrenze.setBounds(new Rectangle(363, 34, 197, 15));
    jLabelObergrenze.setText("Obergrenze der Primzahlen");
    jListPrimTab.setAlignmentX( (float) 0.5);
    jListPrimTab.setAlignmentY( (float) 0.5);
    jListPrimTab.setBorder(null);
    jScrollPanePrimTab.setVerticalScrollBarPolicy(JScrollPane.
                                                  VERTICAL_SCROLLBAR_AS_NEEDED);
    jScrollPanePrimTab.setRowHeader(null);
    jScrollPanePrimTab.setBounds(new Rectangle(9, 52, 208, 310));
    jTextFieldObergrenze.setBounds(new Rectangle(363, 52, 123, 21));
    jTextFieldObergrenze.addActionListener(new
                                           FrameSerie4_jTextFieldObergrenze_actionAdapter(this));
    jTextFieldObergrenze.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldObergrenze.setSelectionEnd(11);
    jTextFieldObergrenze.setText("" + oberGrenze);

    jScrollPanePrimTab.getViewport().add(jListPrimTab, null);

    jPanel1.add(jButtonStartA, null);
    jPanel1.add(jButtonStopA, null);
    jPanel1.add(jLabelTitel1, null);
    jPanel1.add(jLabelObergrenze, null);
    jPanel1.add(jLabelPrimTab, null);
    jPanel1.add(jTextFieldObergrenze, null);
    jPanel1.add(jScrollPanePrimTab, null);

// Panel 2
    jPanel2.setLayout(null);
    jPanel2.setBackground(Color.white);
    jButtonStartB.setText("Start");
    jButtonStartB.addActionListener(new FrameSerie4_jButtonStartB_actionAdapter(this));
    jButtonStartB.setBounds(new Rectangle(425, 90, 73, 25));
    jButtonStopB.setBounds(new Rectangle(425, 124, 73, 25));
    jButtonStopB.setText("Stop");
    jButtonStopB.addActionListener(new FrameSerie4_jButtonStopB_actionAdapter(this));
    jLabelTitel2.setBounds(new Rectangle(1, 6, 564, 23));
    jLabelTitel2.setText(
        "Testumgebung zum Fermat-Test");
    jLabelTitel2.setHorizontalTextPosition(SwingConstants.LEADING);
    jLabelTitel2.setHorizontalAlignment(SwingConstants.LEFT);
    jLabelTitel2.setFont(new java.awt.Font("Times New Roman", 1, 19));
    jLabelAnzTests.setText(
        "Anzahl Tests, die in myIsProbablePrime() gemacht werden sollen");
    jLabelAnzTests.setBounds(new Rectangle(8, 142, 400, 15));
    jLabelBitLaenge.setBounds(new Rectangle(8, 46, 400, 15));
    jLabelBitLaenge.setText("Bitlänge der zu testenden Zufallszahlen");
    jLabelObergrenzeKleineTeiler.setBounds(new Rectangle(8, 94, 400, 15));
    jLabelObergrenzeKleineTeiler.setText("Obergrenze für kleine Primteiler");
    jLabelAnzGetestet.setText("Anzahl getesteter Zahlen");
    jLabelAnzGetestet.setBounds(new Rectangle(129, 208, 196, 15));
    jLabelAnzFehlerAbs.setText("Anzahl Fehler (absolut)");
    jLabelAnzFehlerAbs.setBounds(new Rectangle(129, 239, 196, 15));
    jLabelAnzFehlerRel.setBounds(new Rectangle(129, 269, 196, 15));
    jLabelAnzFehlerRel.setText("Anzahl Fehler (relativ, in %)");

    jTextAreaAnzGetestet.setBounds(new Rectangle(8, 205, 112, 21));
    jTextAreaAnzGetestet.setText("");
    jTextAreaAnzGetestet.setEditable(false);
    jTextAreaAnzGetestet.setBackground(Color.lightGray);
    jTextAreaAnzGetestet.setFont(font);

    jTextAreaAnzFehlerAbs.setBackground(Color.lightGray);
    jTextAreaAnzFehlerAbs.setEditable(false);
    jTextAreaAnzFehlerAbs.setText("");
    jTextAreaAnzFehlerAbs.setBounds(new Rectangle(8, 236, 113, 21));
    jTextAreaAnzFehlerAbs.setFont(font);
    
    jTextAreaAnzFehlerRel.setBounds(new Rectangle(8, 266, 113, 21));
    jTextAreaAnzFehlerRel.setText("");
    jTextAreaAnzFehlerRel.setEditable(false);
    jTextAreaAnzFehlerRel.setBackground(Color.lightGray);
    jTextAreaAnzFehlerRel.setFont(font);
    
    jTextFieldAnzTests.setText("" + anzTests);
    jTextFieldAnzTests.setSelectionEnd(11);
    jTextFieldAnzTests.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldAnzTests.setBounds(new Rectangle(8, 161, 102, 21));
    jTextFieldAnzTests.addActionListener(new
                                         FrameSerie4_jTextFieldAnzTests_actionAdapter(this));
    jTextFieldBitLaenge.addActionListener(new
                                          FrameSerie4_jTextFieldBitLaenge_actionAdapter(this));
    jTextFieldBitLaenge.setBounds(new Rectangle(8, 64, 102, 21));
    jTextFieldBitLaenge.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldBitLaenge.setSelectionEnd(11);
    jTextFieldBitLaenge.setText("" + bitLaenge);

    jTextFieldObergrenzeKleineTeiler.addActionListener(new
                                         FrameSerie4_jTextFieldObergrenzeKleineTeiler_actionAdapter(this));
    jTextFieldObergrenzeKleineTeiler.setBounds(new Rectangle(8, 112, 102, 21));
    jTextFieldObergrenzeKleineTeiler.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldObergrenzeKleineTeiler.setSelectionEnd(11);
    jTextFieldObergrenzeKleineTeiler.setText("" + kleinePrim);

    jPanel2.add(jButtonStartB, null);
    jPanel2.add(jButtonStopB, null);
    jPanel2.add(jLabelTitel2, null);
    jPanel2.add(jTextAreaAnzGetestet, null);
    jPanel2.add(jTextAreaAnzFehlerRel, null);
    jPanel2.add(jTextAreaAnzFehlerAbs, null);
    jPanel2.add(jLabelAnzGetestet, null);
    jPanel2.add(jLabelAnzFehlerAbs, null);
    jPanel2.add(jLabelAnzFehlerRel, null);
    jPanel2.add(jLabelAnzTests, null);
    jPanel2.add(jTextFieldBitLaenge, null);
    jPanel2.add(jLabelBitLaenge, null);
    jPanel2.add(jLabelObergrenzeKleineTeiler, null);
    jPanel2.add(jTextFieldObergrenzeKleineTeiler, null);
    jPanel2.add(jTextFieldAnzTests, null);

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

  void jMenuDateiSchliessen_actionPerformed(ActionEvent e) {
    this.dispose();
  }

  void updateFields() {
    oberGrenze = Integer.valueOf(jTextFieldObergrenze.getText()).intValue();
    anzTests = Integer.valueOf(jTextFieldAnzTests.getText()).intValue();
    bitLaenge = Integer.valueOf(jTextFieldBitLaenge.getText()).intValue();
    kleinePrim = Integer.valueOf(jTextFieldObergrenzeKleineTeiler.getText()).intValue();
  }

  void jTextFieldObergrenze_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldObergrenze.selectAll();
  }

  void jTextFieldObergrenzeKleineTeiler_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldObergrenzeKleineTeiler.selectAll();
  }

  void jTextFieldAnzTests_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldAnzTests.selectAll();
  }

  void jTextFieldBitLaenge_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldBitLaenge.selectAll();
  }

  void jButtonStartA_actionPerformed(ActionEvent e) {
    updateFields();

    // Thread für Testberechnungen starten
    if (primZahlenBerechnen != null) {
      if (primZahlenBerechnen.isAlive()) {
        return;
      }
    }
    primZahlenBerechnen = new PrimZahlenBerechnen(jListPrimTab, oberGrenze);
    primZahlenBerechnen.start();
  }

  void jButtonStopA_actionPerformed(ActionEvent e) {
    updateFields();

    // Thread für Testberechnungen abschiessen
    if (primZahlenBerechnen != null) {
      primZahlenBerechnen.stop();
    }
  }

  void jButtonStartB_actionPerformed(ActionEvent e) {
    updateFields();

    // Thread für Testberechnungen starten
    if (fermatTest != null) {
      if (fermatTest.isAlive()) {
        return;
      }
    }
    BigInteger.createTableOfPrimes(kleinePrim);
    fermatTest = new FermatTest(jTextAreaAnzGetestet, jTextAreaAnzFehlerAbs,
                                jTextAreaAnzFehlerRel,
                                anzTests, bitLaenge);
    fermatTest.start();
  }

  void jButtonStopB_actionPerformed(ActionEvent e) {
    updateFields();

    // Thread für Testberechnungen abschiessen
    if (fermatTest != null) {
      fermatTest.halt();
    }
  }
}

class FrameSerie4_jMenuDateiSchliessen_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie4 adaptee;

  FrameSerie4_jMenuDateiSchliessen_actionAdapter(FrameSerie4 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuDateiSchliessen_actionPerformed(e);
  }
}

class FrameSerie4_jTextFieldObergrenze_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie4 adaptee;

  FrameSerie4_jTextFieldObergrenze_actionAdapter(FrameSerie4 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldObergrenze_actionPerformed(e);
  }
}

class FrameSerie4_jTextFieldAnzTests_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie4 adaptee;

  FrameSerie4_jTextFieldAnzTests_actionAdapter(FrameSerie4 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldAnzTests_actionPerformed(e);
  }
}

class FrameSerie4_jButtonStartA_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie4 adaptee;

  FrameSerie4_jButtonStartA_actionAdapter(FrameSerie4 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartA_actionPerformed(e);
  }
}

class FrameSerie4_jButtonStopA_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie4 adaptee;

  FrameSerie4_jButtonStopA_actionAdapter(FrameSerie4 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStopA_actionPerformed(e);
  }
}

class FrameSerie4_jButtonStartB_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie4 adaptee;

  FrameSerie4_jButtonStartB_actionAdapter(FrameSerie4 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartB_actionPerformed(e);
  }
}

class FrameSerie4_jButtonStopB_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie4 adaptee;

  FrameSerie4_jButtonStopB_actionAdapter(FrameSerie4 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStopB_actionPerformed(e);
  }
}

class FrameSerie4_jTextFieldBitLaenge_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie4 adaptee;

  FrameSerie4_jTextFieldBitLaenge_actionAdapter(FrameSerie4 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldBitLaenge_actionPerformed(e);
  }
}

class PrimZahlenBerechnen
    extends Thread {
  JList primTab;
  int oberGrenze;

  PrimZahlenBerechnen(JList primTab, int oberGrenze) {
    this.primTab = primTab;
    this.oberGrenze = oberGrenze;
    this.setPriority(this.getPriority() - 1);
  }

  public void run() {
    int[] tableOfPrimes;
    String[] strTableOfPrimes;

    // Primzahlen erzeugen
    tableOfPrimes = BigInteger.createTableOfPrimes(oberGrenze);

    // Primzahlen anzeigen
    if (tableOfPrimes != null) {
      strTableOfPrimes = new String[tableOfPrimes.length];
      for (int i = 0; i < tableOfPrimes.length; i++) {
        strTableOfPrimes[i] = "" + tableOfPrimes[i];
      }
      primTab.setListData(strTableOfPrimes);
    }
  }
}

class FermatTest
    extends Thread {
  JTextArea anzGetestet, anzFehlerAbs, anzFehlerRel;
  int anzTests, bitLaenge;
  volatile boolean runFlag;

  FermatTest(JTextArea anzGetestet, JTextArea anzFehlerAbs,
             JTextArea anzFehlerRel,
             int anzTests, int bitLaenge) {
    this.anzGetestet = anzGetestet;
    this.anzFehlerAbs = anzFehlerAbs;
    this.anzFehlerRel = anzFehlerRel;
    this.anzTests = anzTests;
    this.bitLaenge = bitLaenge;
    this.setPriority(this.getPriority() - 1);
    runFlag = true;
  }

  public void run() {
    Random rnd = new Random();
    BigInteger zufallsVar;
    long i = 1;
    long k = 0;
    boolean res1, res2;

    while (runFlag == true) {
      // Zufallszahl erzeugen
      zufallsVar = new BigInteger(bitLaenge, rnd);
      if (zufallsVar.signum() != 1) {
      	continue;
      }

      // Fermat-Test
      res1 = zufallsVar.myIsProbablePrime(anzTests);

      // Test mit schon vorhandener Methode
      res2 = zufallsVar.isProbablePrime(100);

      // Resultate anzeigen
      i++;
      if (res1 != res2) {
        k++;
      }
      anzGetestet.setText(""+i);
      anzFehlerAbs.setText(""+k);
      anzFehlerRel.setText(""+ (float)k / (float)i * 100);
    }
  }

  public void halt() {
    runFlag = false;
  }
}

class FrameSerie4_jTextFieldObergrenzeKleineTeiler_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie4 adaptee;

  FrameSerie4_jTextFieldObergrenzeKleineTeiler_actionAdapter(FrameSerie4 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldObergrenzeKleineTeiler_actionPerformed(e);
  }
}
