package kryptotrainer;

import java.lang.*;

import javax.swing.*;

import java.awt.*;
import java.awt.event.*;
import java.util.Random;
import java.sql.Time;

import mybiginteger.*;

/**
 * <p>Title: KryptoTrainer</p>
 * <p>Description: Übungsumgebung für das Wahlfach Kryptologie</p>
 * <p>Copyright: Copyright (c) 2006 / Samuel Beer</p>
 * <p>Company: Zürcher Hochschule Winterthur</p>
 * @author Samuel Beer
 * @version 1.0
 */

public class FrameSerie6
    extends JFrame {
// Elemente des Frames
  JPanel contentPane;
  GridLayout gridLayoutContentPane = new GridLayout();
  JMenuBar jMenuBar1 = new JMenuBar();
  JPanel jPanel1 = new JPanel();

// Elemente der MenuBar
  JMenu jMenuDatei = new JMenu();
  JMenuItem jMenuDateiSchliessen = new JMenuItem();

// Elemente jPanel1
  JButton jButtonStart = new JButton();
  JButton jButtonStop = new JButton();
  JComboBox jComboBoxAnzWied;
  JLabel jLabelTitel = new JLabel();
  JLabel jLabelZeit = new JLabel();
  JLabel jLabelAnzStellen = new JLabel();
  JLabel jLabelUntertitel = new JLabel();
  JLabel jLabelAnzWied = new JLabel();
  JLabel jLabelRes = new JLabel();
  JLabel jLabelSicherheit = new JLabel();
  JLabel jLabelPrimTab = new JLabel();
  JLabel jLabelIstSicher = new JLabel();
  JTextArea jTextAreaZeit = new JTextArea();
  JTextArea jTextAreaIstSicher = new JTextArea();
  JTextField jTextFieldAnzStellen = new JTextField();
  JTextField jTextFieldSicherheit = new JTextField();
  JTextField jTextFieldPrimTab = new JTextField();
  JTextArea jTextAreaRes = new JTextArea();

  String[] anzWiedStrings = {
      "1", "10", "100", "1000", "10000"};
  Serie6TestBerechnungen testBerechnungen = null;
  int anzStellen;
  int primTab;
  int anzWiederholungen;
  int sicherheit;
    public FrameSerie6() {
    try {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
// Allgemeine Initialisierungen
    jComboBoxAnzWied = new JComboBox(anzWiedStrings);
    this.setSize(new Dimension(600, 550));
    this.setTitle("KryptoTrainer Testumgebung zum Praktikum 8.1");

// Menu
    jMenuDatei.setText("Datei");
    jMenuDateiSchliessen.setText("Schliessen");
    jMenuDateiSchliessen.addActionListener(new
                                           FrameSerie6_jMenuDateiSchliessen_actionAdapter(this));
        jMenuDatei.add(jMenuDateiSchliessen);
    jMenuBar1.add(jMenuDatei);
    this.setJMenuBar(jMenuBar1);

// Schriftart und Grösse für JTextArea Felder
    Font font = new Font(Font.MONOSPACED, Font.PLAIN, 13);
    
// Panel 1
    anzStellen = 16;
    sicherheit = 10;
    primTab = 1;
    anzWiederholungen = Integer.valueOf(anzWiedStrings[0]).intValue();

    jPanel1.setLayout(null);
    jPanel1.setBackground(Color.white);
    jLabelTitel.setFont(new java.awt.Font("Times New Roman", 1, 19));
    jLabelTitel.setHorizontalAlignment(SwingConstants.LEFT);
    jLabelTitel.setHorizontalTextPosition(SwingConstants.LEADING);
    jLabelTitel.setText("Testumgebung zu sicheren Primzahlen");
    jLabelTitel.setBounds(new Rectangle(1, 1, 564, 23));

    jButtonStart.setBounds(new Rectangle(491, 47, 62, 25));
    jButtonStart.setText("Start");
    jButtonStart.addActionListener(new FrameSerie6_jButtonStart_actionAdapter(this));
    jLabelZeit.setText("Totale Rechenzeit");
    jLabelZeit.setBounds(new Rectangle(4, 312, 158, 15));
    jLabelAnzStellen.setBounds(new Rectangle(65, 54, 255, 15));
    jLabelAnzStellen.setText("Bitlänge der sicheren Primzahlen");
    jLabelIstSicher.setText("Sichere Primzahl?");
    jLabelIstSicher.setBounds(new Rectangle(246, 312, 158, 15));
    jLabelUntertitel.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelUntertitel.setText("Ergebnis und Laufzeit");
    jLabelUntertitel.setBounds(new Rectangle(4, 31, 255, 17));
    jTextFieldAnzStellen.setSelectionEnd(11);
    jTextFieldAnzStellen.setText("" + anzStellen);
    jTextFieldAnzStellen.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldAnzStellen.setBounds(new Rectangle(4, 51, 57, 21));
    jTextFieldAnzStellen.addActionListener(new FrameSerie6_jTextFieldAnzStellen_actionAdapter(this));
    jLabelAnzWied.setText("Anzahl sicherer Primzahlen");
    jLabelAnzWied.setBounds(new Rectangle(65, 155, 311, 15));
    jLabelRes.setText("Zuletzt bestimmte sichere Primzahl");
    jLabelRes.setBounds(new Rectangle(4, 227, 373, 15));
    jTextAreaRes.setBackground(Color.lightGray);
    jTextAreaRes.setBorder(BorderFactory.createEtchedBorder());
    jTextAreaRes.setEditable(false);
    jTextAreaRes.setText("");
    jTextAreaRes.setBounds(new Rectangle(4, 242, 373, 63));
    jTextAreaRes.setFont(font);
    jTextAreaRes.setLineWrap(true);

    jButtonStop.setBounds(new Rectangle(491, 73, 62, 25));
    jButtonStop.setText("Stop");
    jButtonStop.addActionListener(new FrameSerie6_jButtonStop_actionAdapter(this));
    jTextAreaZeit.setBackground(Color.lightGray);
    jTextAreaZeit.setEditable(false);
    jTextAreaZeit.setText("");
    jTextAreaZeit.setBounds(new Rectangle(4, 327, 131, 21));
    jTextAreaZeit.setFont(font);

    jTextAreaIstSicher.setBackground(Color.lightGray);
    jTextAreaIstSicher.setEditable(false);
    jTextAreaIstSicher.setBounds(new Rectangle(246, 327, 131, 21));
    jTextAreaIstSicher.setFont(font);

    jComboBoxAnzWied.setBounds(new Rectangle(4, 152, 57, 21));
    jComboBoxAnzWied.addActionListener(new FrameSerie6_jComboBoxAnzWied_actionAdapter(this));
    gridLayoutContentPane.setRows(1);
    jLabelSicherheit.setText("Anzahl Durchläufe beim Primzahltest");
    jTextFieldSicherheit.addActionListener(new FrameSerie6_jTextFieldSicherheit_actionAdapter(this));
    jTextFieldSicherheit.addActionListener(new FrameSerie6_jTextFieldSicherheit_actionAdapter(this));
    jTextFieldSicherheit.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldSicherheit.setText("" + sicherheit);
    jTextFieldSicherheit.setSelectionEnd(11);
    jTextFieldPrimTab.setText("" + primTab);
    jTextFieldPrimTab.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldPrimTab.setBounds(new Rectangle(4, 118, 57, 21));
    jTextFieldPrimTab.addActionListener(new
            FrameSerie6_jTextFieldPrimTab_actionAdapter(this));
    jLabelPrimTab.setText("Obergrenze der Primzahltabelle");
    jLabelPrimTab.setBounds(new Rectangle(65, 121, 255, 15));
    jTextFieldSicherheit.setBounds(new Rectangle(4, 85, 57, 21));
    jLabelSicherheit.setBounds(new Rectangle(65, 88, 255, 15));

    jPanel1.add(jLabelTitel, null);
    jPanel1.add(jButtonStart, null);
    jPanel1.add(jLabelAnzStellen, null);
    jPanel1.add(jButtonStop, null);
    jPanel1.add(jLabelUntertitel, null);
    jPanel1.add(jTextFieldAnzStellen, null);
    jPanel1.add(jComboBoxAnzWied, null);
    jPanel1.add(jLabelAnzWied, null);
    jPanel1.add(jLabelSicherheit, null);
    jPanel1.add(jTextFieldSicherheit, null);
    jPanel1.add(jTextFieldPrimTab);
    jPanel1.add(jLabelPrimTab);
    jPanel1.add(jTextAreaRes, null);
    jPanel1.add(jLabelRes, null);
    jPanel1.add(jLabelZeit, null);
    jPanel1.add(jTextAreaZeit, null);
    jPanel1.add(jTextAreaIstSicher);
    jPanel1.add(jLabelIstSicher);
        contentPane = (JPanel)this.getContentPane();
    contentPane.setMinimumSize(new Dimension(600, 800));
    contentPane.setPreferredSize(new Dimension(600, 800));
    gridLayoutContentPane.setColumns(1);
    contentPane.setLayout(gridLayoutContentPane);

    contentPane.add(jPanel1, null);
    }

  void jButtonStart_actionPerformed(ActionEvent e) {
    updateFields();
    BigInteger.createTableOfPrimes(primTab);

    // Thread für Testberechnungen starten
    if (testBerechnungen != null) {
      if (testBerechnungen.isAlive()) {
        return;
      }
    }
    testBerechnungen = new Serie6TestBerechnungen(jTextAreaZeit,
                                                  jTextAreaIstSicher,
                                                  jTextAreaRes,
                                                  anzWiederholungen,
                                                  anzStellen,
                                                  sicherheit);
    testBerechnungen.start();
  }

  void jButtonStop_actionPerformed(ActionEvent e) {
    updateFields();

    // Thread für Testberechnungen abschiessen
    if (testBerechnungen != null) {
      testBerechnungen.stop();
    }
  }

  void jComboBoxAnzWied_actionPerformed(ActionEvent e) {
    updateFields();
    JComboBox cb = (JComboBox) e.getSource();
    String str = (String) cb.getSelectedItem();
    anzWiederholungen = Integer.valueOf(str).intValue();
  }

  void jMenuDateiSchliessen_actionPerformed(ActionEvent e) {
    this.dispose();
  }

  void jTextFieldAnzStellen_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldAnzStellen.selectAll();
  }

  void jTextFieldSicherheit_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldSicherheit.selectAll();
  }

  public void jTextFieldPrimTab_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldPrimTab.selectAll();
  }

  void updateFields() {
    anzStellen = Integer.valueOf(jTextFieldAnzStellen.getText()).intValue();
    sicherheit = Integer.valueOf(jTextFieldSicherheit.getText()).intValue();
    primTab = Integer.valueOf(jTextFieldPrimTab.getText()).intValue();
  }
}


class FrameSerie6_jTextFieldPrimTab_actionAdapter implements ActionListener {
    private FrameSerie6 adaptee;
    FrameSerie6_jTextFieldPrimTab_actionAdapter(FrameSerie6 adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.jTextFieldPrimTab_actionPerformed(e);
    }
}


class FrameSerie6_jMenuDateiSchliessen_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie6 adaptee;

  FrameSerie6_jMenuDateiSchliessen_actionAdapter(FrameSerie6 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuDateiSchliessen_actionPerformed(e);
  }
}

class Serie6TestBerechnungen
    extends Thread {
  JTextArea zeit;
  JTextArea istSicher;
  JTextArea res;
  int anzWiederholungen, anzStellen, sicherheit;

  Serie6TestBerechnungen(JTextArea zeit, JTextArea istSicher, JTextArea res,
                         int anzWiederholungen, int anzStellen, int sicherheit) {
    this.zeit = zeit;
    this.istSicher = istSicher;
    this.res = res;
    this.anzWiederholungen = anzWiederholungen;
    this.anzStellen = anzStellen;
    this.sicherheit = sicherheit;
    this.setPriority(this.getPriority() - 1);
  }

  public void run() {
      int i;
      BigInteger p = BigInteger.ZERO;
      BigInteger q;
      Random rnd = new Random();
      Time zeitStempelAnf;
      Time zeitStempelEnd;

      // Berechnung der sicheren Primzahlen
      zeitStempelAnf = new Time(System.currentTimeMillis());
      for (i = 0; i < anzWiederholungen; i++) {
          p = BigInteger.myProbableSafePrime(anzStellen, sicherheit, rnd);
      }
      zeitStempelEnd = new Time(System.currentTimeMillis());
      zeit.setText("" + (zeitStempelEnd.getTime() - zeitStempelAnf.getTime()) +
                   " ms");
      res.setText(p.toString());
      if (p.isProbablePrime(sicherheit)) {
          q = p.subtract(BigInteger.ONE).shiftRight(1);
          if (q.isProbablePrime(sicherheit)) {
              istSicher.setText("Ja");
          } else {
              istSicher.setText("q nicht prim");
          }
      } else {
          istSicher.setText("p nicht prim");
      }
  }
}

class FrameSerie6_jButtonStart_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie6 adaptee;

  FrameSerie6_jButtonStart_actionAdapter(FrameSerie6 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStart_actionPerformed(e);
  }
}

class FrameSerie6_jButtonStop_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie6 adaptee;

  FrameSerie6_jButtonStop_actionAdapter(FrameSerie6 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStop_actionPerformed(e);
  }
}

class FrameSerie6_jTextFieldAnzStellen_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie6 adaptee;

  FrameSerie6_jTextFieldAnzStellen_actionAdapter(FrameSerie6 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldAnzStellen_actionPerformed(e);
  }
}

class FrameSerie6_jComboBoxAnzWied_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie6 adaptee;

  FrameSerie6_jComboBoxAnzWied_actionAdapter(FrameSerie6 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jComboBoxAnzWied_actionPerformed(e);
  }
}

class FrameSerie6_jTextFieldSicherheit_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie6 adaptee;

  FrameSerie6_jTextFieldSicherheit_actionAdapter(FrameSerie6 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldSicherheit_actionPerformed(e);
  }
}
