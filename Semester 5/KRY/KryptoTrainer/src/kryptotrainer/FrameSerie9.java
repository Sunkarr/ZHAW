package kryptotrainer;
import java.lang.*;
import java.sql.Time;
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

public class FrameSerie9
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
  JButton jButtonStopA = new JButton();
  JLabel jLabelTitel = new JLabel();
  JLabel jLabelUntertitelA = new JLabel();
  JLabel jLabelEingabe = new JLabel();
  JLabel jLabelAusgabe1 = new JLabel();
  JLabel jLabelAusgabe2 = new JLabel();
  JTextField jTextFieldEingabe = new JTextField();
  JTextPane jTextPaneAusgabe1 = new JTextPane();
  JTextPane jTextPaneAusgabe2 = new JTextPane();

// Elemente jPanel2
  JLabel jLabelUntertitelB = new JLabel();
  JLabel jLabelTest1 = new JLabel();
  JLabel jLabelTest2 = new JLabel();
  JTextPane jTextPaneTest1 = new JTextPane();
  JTextPane jTextPaneTest2 = new JTextPane();

// Klassenvariablen
  private BigInteger eingabe = BigInteger.ZERO;
  PollardFaktorisieren pollardFaktorisieren;

  public FrameSerie9() {
    try {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
// Allgemeine Initialisierungen
    this.setSize(new Dimension(650, 416));
    this.setTitle("KryptoTrainer Testumgebung zum Praktikum 10.2");

// Menu
    jMenuDatei.setText("Datei");
    jMenuDateiSchliessen.setText("Schliessen");
    jMenuDateiSchliessen.addActionListener(new
                                           FrameSerie9_jMenuDateiSchliessen_actionAdapter(this));

    jMenuDatei.add(jMenuDateiSchliessen);

    jMenuBar1.add(jMenuDatei);
    this.setJMenuBar(jMenuBar1);

// Panel 1
    jPanel1.setLayout(null);
    jPanel1.setBackground(Color.white);
    jButtonStartA.setText("Start");
    jButtonStartA.setBounds(new Rectangle(413, 108, 62, 25));
    jButtonStartA.addActionListener(new FrameSerie9_jButtonStartA_actionAdapter(this));
    jButtonStopA.setText("Stop");
    jButtonStopA.setBounds(new Rectangle(500, 108, 62, 25));
    jButtonStopA.addActionListener(new FrameSerie9_jButtonStopA_actionAdapter(this));
    jLabelTitel.setFont(new java.awt.Font("Times New Roman", 1, 19));
    jLabelTitel.setHorizontalAlignment(SwingConstants.LEFT);
    jLabelTitel.setHorizontalTextPosition(SwingConstants.LEADING);
    jLabelTitel.setText("Testumgebung zur Methode myPollardRho()");
    jLabelTitel.setBounds(new Rectangle(1, 1, 564, 23));
    jLabelUntertitelA.setText("a) Testberechnung");
    jLabelUntertitelA.setBounds(new Rectangle(9, 29, 255, 17));
    jLabelUntertitelA.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelEingabe.setText("Eingabewert n");
    jLabelEingabe.setBounds(new Rectangle(9, 56, 188, 15));
    jLabelAusgabe1.setBounds(new Rectangle(9, 125, 200, 15));
    jLabelAusgabe1.setText("Erster Faktor r von n");
    jLabelAusgabe2.setBounds(new Rectangle(291, 125, 200, 15));
    jLabelAusgabe2.setText("Zeit [ms]");
    jTextFieldEingabe.setText(eingabe.toString());
    jTextFieldEingabe.setBounds(new Rectangle(9, 75, 553, 21));
    jTextFieldEingabe.addActionListener(new
                                      FrameSerie9_jTextFieldEingabe_actionAdapter(this));
    jTextFieldEingabe.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldEingabe.setSelectionEnd(11);
    jTextFieldEingabe.setNextFocusableComponent(null);
    jTextPaneAusgabe1.setText("0");
    jTextPaneAusgabe1.setBounds(new Rectangle(9, 144, 271, 21));
    jTextPaneAusgabe1.setEditable(false);
    jTextPaneAusgabe1.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneAusgabe1.setBackground(Color.lightGray);
    jTextPaneAusgabe2.setText("0");
    jTextPaneAusgabe2.setBounds(new Rectangle(291, 144, 271, 21));
    jTextPaneAusgabe2.setEditable(false);
    jTextPaneAusgabe2.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneAusgabe2.setBackground(Color.lightGray);

    jPanel1.add(jLabelTitel, null);
    jPanel1.add(jLabelUntertitelA, null);
    jPanel1.add(jTextFieldEingabe, null);
    jPanel1.add(jLabelEingabe, null);
    jPanel1.add(jButtonStartA, null);
    jPanel1.add(jButtonStopA, null);
    jPanel1.add(jTextPaneAusgabe1, null);
    jPanel1.add(jLabelAusgabe1, null);
    jPanel1.add(jTextPaneAusgabe2, null);
    jPanel1.add(jLabelAusgabe2, null);

// Panel 2
    jPanel2.setLayout(null);
    jPanel2.setBackground(Color.white);
    jLabelUntertitelB.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelUntertitelB.setText("b) Test durch Zurückrechnen");
    jLabelUntertitelB.setBounds(new Rectangle(9, 3, 391, 17));
    jLabelTest1.setText("Zweiter Faktor s von n");
    jLabelTest1.setBounds(new Rectangle(10, 32, 332, 15));
    jLabelTest2.setText("r*s - n (sollte Null sein)");
    jLabelTest2.setBounds(new Rectangle(10, 104, 332, 15));
    jTextPaneTest1.setBackground(Color.lightGray);
    jTextPaneTest1.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneTest1.setEditable(false);
    jTextPaneTest1.setBounds(new Rectangle(10, 51, 553, 21));
    jTextPaneTest1.setText("0");
    jTextPaneTest2.setText("0");
    jTextPaneTest2.setBounds(new Rectangle(10, 123, 553, 21));
    jTextPaneTest2.setEditable(false);
    jTextPaneTest2.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneTest2.setBackground(Color.lightGray);

    jPanel2.add(jLabelUntertitelB, null);
    jPanel2.add(jTextPaneTest1, null);
    jPanel2.add(jLabelTest1, null);
    jPanel2.add(jTextPaneTest2, null);
    jPanel2.add(jLabelTest2, null);

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

    // Thread für Testberechnungen starten
    if (pollardFaktorisieren != null) {
      if (pollardFaktorisieren.isAlive()) {
        return;
      }
    }
    
    jTextPaneAusgabe1.setText("Bitte warten...");
    jTextPaneAusgabe2.setText("");
    jTextPaneTest1.setText("");
   	jTextPaneTest2.setText("");
    
    pollardFaktorisieren = new PollardFaktorisieren(jTextPaneAusgabe1, jTextPaneAusgabe2,
             jTextPaneTest1, jTextPaneTest2, eingabe);
    pollardFaktorisieren.start();
  }

  void jButtonStopA_actionPerformed(ActionEvent e) {
    updateFields();

    // Thread für Testberechnungen abschiessen
    if (pollardFaktorisieren != null) {
      if (pollardFaktorisieren.isAlive()) {
      	jTextPaneAusgabe1.setText("Abgebrochen...");
      	jTextPaneAusgabe2.setText("");
        jTextPaneTest1.setText("");
   	    jTextPaneTest2.setText("");
        pollardFaktorisieren.stop();
      }
    }
  }

  void jMenuDateiSchliessen_actionPerformed(ActionEvent e) {
    this.dispose();
  }

  void jTextFieldEingabe_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldEingabe.selectAll();
  }

  void updateFields() {
    eingabe = new BigInteger(jTextFieldEingabe.getText());
  }
}

class FrameSerie9_jMenuDateiSchliessen_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie9 adaptee;

  FrameSerie9_jMenuDateiSchliessen_actionAdapter(FrameSerie9 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuDateiSchliessen_actionPerformed(e);
  }
}

class FrameSerie9_jButtonStartA_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie9 adaptee;

  FrameSerie9_jButtonStartA_actionAdapter(FrameSerie9 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartA_actionPerformed(e);
  }
}

class FrameSerie9_jButtonStopA_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie9 adaptee;

  FrameSerie9_jButtonStopA_actionAdapter(FrameSerie9 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStopA_actionPerformed(e);
  }
}

class FrameSerie9_jTextFieldEingabe_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie9 adaptee;

  FrameSerie9_jTextFieldEingabe_actionAdapter(FrameSerie9 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldEingabe_actionPerformed(e);
  }
}

class PollardFaktorisieren
    extends Thread {
  JTextPane paneAusgabe1, paneAusgabe2, paneTest1, paneTest2;
  BigInteger eingabe, ausgabe, test1, test2;

  PollardFaktorisieren(JTextPane paneAusgabe1, JTextPane paneAusgabe2,
             JTextPane paneTest1, JTextPane paneTest2, BigInteger eingabe) {

    this.paneAusgabe1 = paneAusgabe1;
    this.paneAusgabe2 = paneAusgabe2;
    this.paneTest1 = paneTest1;
    this.paneTest2 = paneTest2;
    
    this.eingabe = eingabe;
    
    this.setPriority(this.getPriority() - 1);
  }
  
  public void run() {
  	Time zeitStempelAnf;
    Time zeitStempelEnd;

    zeitStempelAnf = new Time(System.currentTimeMillis());
    ausgabe = eingabe.myPollardRho();
    zeitStempelEnd = new Time(System.currentTimeMillis());

    paneAusgabe1.setText(ausgabe.toString());
    paneAusgabe2.setText("" + (zeitStempelEnd.getTime() - zeitStempelAnf.getTime()));

    if (ausgabe.equals(BigInteger.ONE)) {
    	test1 = BigInteger.ZERO;
    	test2 = BigInteger.ZERO;
	    paneTest1.setText("n ist eine Primzahl!");
    	paneTest2.setText("");
    }
    else {
    	test1 = eingabe.divide(ausgabe);
    	test2 = test1.multiply(ausgabe).subtract(eingabe);
    	paneTest1.setText(test1.toString());
    	paneTest2.setText(test2.toString());
    }
  }
}

