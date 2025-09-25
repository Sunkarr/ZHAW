package kryptotrainer;

import java.lang.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import mybiginteger.*;
import java.sql.Time;

/**
 * <p>Title: KryptoTrainer</p>
 * <p>Description: Übungsumgebung für das Wahlfach Kryptologie</p>
 * <p>Copyright: Copyright (c) 2006 / Samuel Beer</p>
 * <p>Company: Zürcher Hochschule Winterthur</p>
 * @author Samuel Beer
 * @version 1.0
 */

public class FrameSerieZ
    extends JFrame {
// Elemente des Frames
  JPanel contentPane;
  GridLayout gridLayoutContentPane = new GridLayout();
  JMenuBar jMenuBar1 = new JMenuBar();
  JPanel jPanel1 = new JPanel();
  JPanel jPanel2 = new JPanel(); // Elemente der MenuBar
  JMenu jMenuDatei = new JMenu();
  JMenuItem jMenuDateiSchliessen = new JMenuItem();

// Elemente jPanel1
  JButton jButtonStartA = new JButton();
  JLabel jLabelTitel = new JLabel();
  JLabel jLabelUntertitelA = new JLabel();
  JLabel jLabelSchluesselLaenge = new JLabel();
  JLabel jLabelOeffSchl_p = new JLabel();
  JLabel jLabelOeffSchl_g = new JLabel();
  JLabel jLabelOeffSchl_A = new JLabel();
  JLabel jLabelPrivSchl_a = new JLabel();
  JTextField jTextFieldSchluesselLaenge = new JTextField();
  JTextPane jTextPaneOeffSchl_p = new JTextPane();
  JTextPane jTextPaneOeffSchl_g = new JTextPane();
  JTextPane jTextPaneOeffSchl_A = new JTextPane();
  JTextPane jTextPanePrivSchl_a = new JTextPane();

// Elemente jPanel2
  JButton jButtonStartB = new JButton();
  JButton jButtonStopB = new JButton();
  JLabel jLabelUntertitelB = new JLabel();
  JLabel jLabelRes = new JLabel();
  JTextPane jTextPaneRes = new JTextPane();
  JTextPane jTextPaneZeit = new JTextPane();
  JLabel jLabelZeit = new JLabel();

  boolean buttonPressedA = false;
  int anzStellen = 8;
  BigInteger[] oeffSchl;
  BigInteger privSchl;
  ElGamal kryptoSystem = new ElGamal();
  SerieZBerechnungen berechnungenB;

  public FrameSerieZ() {
    try {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
// Allgemeine Initialisierungen
    this.setSize(new Dimension(600, 600));
    this.setTitle("KryptoTrainer Testumgebung zum Praktikum 12.2");

// Menu
    jMenuDatei.setText("Datei");
    jMenuDateiSchliessen.setText("Schliessen");
    jMenuDateiSchliessen.addActionListener(new FrameSerieZ_jMenuDateiSchliessen_actionAdapter(this));
    jButtonStopB.setBounds(new Rectangle(499, 98, 62, 25));
    jButtonStopB.setText("Stop");
    jButtonStopB.addActionListener(new FrameSerieZ_jButtonStopB_actionAdapter(this));
    jMenuDatei.add(jMenuDateiSchliessen);

    jMenuBar1.add(jMenuDatei);
    this.setJMenuBar(jMenuBar1);

// Panel 1
    jPanel1.setLayout(null);
    jPanel1.setBackground(Color.white);
    jButtonStartA.setText("Start");
    jButtonStartA.setBounds(new Rectangle(496, 46, 62, 25));
    jButtonStartA.addActionListener(new FrameSerieZ_jButtonStartA_actionAdapter(this));
    jLabelTitel.setFont(new java.awt.Font("Times New Roman", 1, 19));
    jLabelTitel.setHorizontalAlignment(SwingConstants.LEFT);
    jLabelTitel.setHorizontalTextPosition(SwingConstants.LEADING);
    jLabelTitel.setText("Testumgebung zur Berechnung von diskreten Logarithmen");
    jLabelTitel.setBounds(new Rectangle(1, 1, 564, 23));
    jLabelUntertitelA.setText("a) Schlüsselerzeugung für das El Gamal System");
    jLabelUntertitelA.setBounds(new Rectangle(9, 29, 467, 17));
    jLabelUntertitelA.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelSchluesselLaenge.setText("Schlüssellänge");
    jLabelSchluesselLaenge.setBounds(new Rectangle(90, 51, 188, 15));
    jLabelOeffSchl_p.setText("Öffentlicher Schlüssel p");
    jLabelOeffSchl_p.setBounds(new Rectangle(383, 87, 196, 15));
    jLabelOeffSchl_g.setBounds(new Rectangle(383, 126, 196, 15));
    jLabelOeffSchl_g.setText("Öffentlicher Schlüssel g");
    jLabelOeffSchl_A.setBounds(new Rectangle(383, 164, 196, 15));
    jLabelOeffSchl_A.setText("Öffentlicher Schlüssel A");
    jLabelPrivSchl_a.setBounds(new Rectangle(383, 213, 196, 15));
    jLabelPrivSchl_a.setText("Privater Schlüssel a");
    jTextFieldSchluesselLaenge.setText("" + anzStellen);
    jTextFieldSchluesselLaenge.setBounds(new Rectangle(9, 48, 79, 21));
    jTextFieldSchluesselLaenge.addActionListener(new
                                      FrameSerieZ_jTextFieldSchluesselLaenge_actionAdapter(this));
    jTextFieldSchluesselLaenge.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldSchluesselLaenge.setSelectionEnd(11);
    jTextPaneOeffSchl_p.setText("");
    jTextPaneOeffSchl_p.setBounds(new Rectangle(8, 74, 373, 40));
    jTextPaneOeffSchl_p.setEditable(false);
    jTextPaneOeffSchl_p.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneOeffSchl_p.setBackground(Color.lightGray);
    jTextPaneOeffSchl_g.setBackground(Color.lightGray);
    jTextPaneOeffSchl_g.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneOeffSchl_g.setEditable(false);
    jTextPaneOeffSchl_g.setBounds(new Rectangle(8, 113, 373, 40));
    jTextPaneOeffSchl_g.setText("");
    jTextPaneOeffSchl_A.setBackground(Color.lightGray);
    jTextPaneOeffSchl_A.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneOeffSchl_A.setEditable(false);
    jTextPaneOeffSchl_A.setBounds(new Rectangle(8, 151, 373, 40));
    jTextPaneOeffSchl_A.setText("");
    jTextPanePrivSchl_a.setText("");
    jTextPanePrivSchl_a.setBounds(new Rectangle(8, 200, 373, 40));
    jTextPanePrivSchl_a.setEditable(false);
    jTextPanePrivSchl_a.setBorder(BorderFactory.createEtchedBorder());
    jTextPanePrivSchl_a.setBackground(Color.lightGray);

    jPanel1.add(jButtonStartA, null);
    jPanel1.add(jLabelTitel, null);
    jPanel1.add(jLabelUntertitelA, null);
    jPanel1.add(jLabelSchluesselLaenge, null);
    jPanel1.add(jLabelOeffSchl_p, null);
    jPanel1.add(jLabelOeffSchl_g, null);
    jPanel1.add(jLabelOeffSchl_A, null);
    jPanel1.add(jLabelPrivSchl_a, null);
    jPanel1.add(jTextFieldSchluesselLaenge, null);
    jPanel1.add(jTextPaneOeffSchl_p, null);
    jPanel1.add(jTextPaneOeffSchl_g, null);
    jPanel1.add(jTextPaneOeffSchl_A, null);
    jPanel1.add(jTextPanePrivSchl_a, null);

// Panel 2
    jPanel2.setLayout(null);
    jPanel2.setBackground(Color.white);
    jButtonStartB.setBounds(new Rectangle(499, 57, 62, 25));
    jButtonStartB.setText("Start");
    jButtonStartB.addActionListener(new FrameSerieZ_jButtonStartB_actionAdapter(this));
    jLabelUntertitelB.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelUntertitelB.setText("b) Berechnung des privaten Schlüssels aus dem öffentlichen Schlüssel");
    jLabelUntertitelB.setBounds(new Rectangle(9, 3, 510, 17));
    jLabelRes.setText("Berechne den diskr. Log. von A zur Basis g (sollte a ergeben):");
    jLabelRes.setBounds(new Rectangle(9, 23, 411, 18));
    jTextPaneRes.setBackground(Color.lightGray);
    jTextPaneRes.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneRes.setEditable(false);
    jTextPaneRes.setBounds(new Rectangle(9, 44, 373, 24));
    jTextPaneZeit.setBackground(Color.lightGray);
    jTextPaneZeit.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneZeit.setEditable(false);
    jTextPaneZeit.setBounds(new Rectangle(9, 104, 373, 24));
    jLabelZeit.setText("Dauer der Berechnung:");
    jLabelZeit.setBounds(new Rectangle(9, 84, 411, 18));

    jPanel2.add(jLabelUntertitelB, null);
    jPanel2.add(jTextPaneRes);
    jPanel2.add(jLabelRes);
    jPanel2.add(jTextPaneZeit);
    jPanel2.add(jLabelZeit);
    jPanel2.add(jButtonStartB, null);
    jPanel2.add(jButtonStopB);
    contentPane = (JPanel)this.getContentPane();
    contentPane.setMinimumSize(new Dimension(600, 600));
    contentPane.setPreferredSize(new Dimension(600, 600));
    gridLayoutContentPane.setColumns(1);
    gridLayoutContentPane.setRows(2);
    contentPane.setLayout(gridLayoutContentPane);

    contentPane.add(jPanel1, null);
    contentPane.add(jPanel2, null);
  }

  void jButtonStartA_actionPerformed(ActionEvent e) {
    updateFields();

    buttonPressedA = true;

    kryptoSystem.setBitLength(anzStellen);
    kryptoSystem.generateKeyPair();

    oeffSchl = kryptoSystem.getPublicKey();
    privSchl = kryptoSystem.getPrivateKey();
    jTextPaneOeffSchl_p.setText(oeffSchl[0].toString());
    jTextPaneOeffSchl_g.setText(oeffSchl[1].toString());
    jTextPaneOeffSchl_A.setText(oeffSchl[2].toString());
    jTextPanePrivSchl_a.setText(privSchl.toString());
  }

  void jButtonStartB_actionPerformed(ActionEvent e) {
    updateFields();

    if (buttonPressedA) {
      // Thread für Berechnungen starten
      if (berechnungenB != null) {
        if (berechnungenB.isAlive()) {
          return;
        }
      }
      berechnungenB = new SerieZBerechnungen(jTextPaneRes, jTextPaneZeit, oeffSchl);
      berechnungenB.start();
    }
  }

  public void jButtonStopB_actionPerformed(ActionEvent e) {
    updateFields();

    if (berechnungenB != null) {
      berechnungenB.stop();
    }
  }

  void jMenuDateiSchliessen_actionPerformed(ActionEvent e) {
    this.dispose();
  }

  void jTextFieldSchluesselLaenge_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldSchluesselLaenge.selectAll();
  }

  void updateFields() {
    anzStellen = Integer.valueOf(jTextFieldSchluesselLaenge.getText()).intValue();
  }
}

class FrameSerieZ_jButtonStopB_actionAdapter
    implements ActionListener {
  private FrameSerieZ adaptee;
  FrameSerieZ_jButtonStopB_actionAdapter(FrameSerieZ adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStopB_actionPerformed(e);
  }
}

class FrameSerieZ_jMenuDateiSchliessen_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerieZ adaptee;

  FrameSerieZ_jMenuDateiSchliessen_actionAdapter(FrameSerieZ adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuDateiSchliessen_actionPerformed(e);
  }
}

class FrameSerieZ_jButtonStartB_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerieZ adaptee;

  FrameSerieZ_jButtonStartB_actionAdapter(FrameSerieZ adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartB_actionPerformed(e);
  }
}

class FrameSerieZ_jButtonStartA_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerieZ adaptee;

  FrameSerieZ_jButtonStartA_actionAdapter(FrameSerieZ adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartA_actionPerformed(e);
  }
}

class FrameSerieZ_jTextFieldSchluesselLaenge_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerieZ adaptee;

  FrameSerieZ_jTextFieldSchluesselLaenge_actionAdapter(FrameSerieZ adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldSchluesselLaenge_actionPerformed(e);
  }
}

class SerieZBerechnungen
    extends Thread {
  JTextPane res, zeit;
  BigInteger[] oeffSchl;

  SerieZBerechnungen(JTextPane res, JTextPane zeit, BigInteger[] oeffSchl) {
    this.res = res;
    this.zeit = zeit;
    this.oeffSchl = oeffSchl;
    this.setPriority(this.getPriority() - 1);
  }

  public void run() {
    BigInteger berechnPrivSchl;
    Time zeitStempelAnf;
    Time zeitStempelEnd;

    zeitStempelAnf = new Time(System.currentTimeMillis());

    // Privaten Schlüssel zu berechnen versuchen
    berechnPrivSchl = oeffSchl[2].myModLog(oeffSchl[1], oeffSchl[0]);

    zeitStempelEnd = new Time(System.currentTimeMillis());

    // Ergebnis anzeigen
    res.setText(berechnPrivSchl.toString());
    zeit.setText("" + (zeitStempelEnd.getTime() - zeitStempelAnf.getTime()) + " ms");
  }
}
