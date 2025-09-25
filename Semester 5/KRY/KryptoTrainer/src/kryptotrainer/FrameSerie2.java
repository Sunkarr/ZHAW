package kryptotrainer;

import java.lang.*;

import javax.swing.*;

import java.awt.*;
import java.awt.event.*;
import java.util.Random;
import java.sql.Time;

import ptolemy.plot.*;
import mybiginteger.*;

/**
 * <p>Title: KryptoTrainer</p>
 * <p>Description: Übungsumgebung für das Wahlfach Kryptologie</p>
 * <p>Copyright: Copyright (c) 2006 / Samuel Beer</p>
 * <p>Company: Zürcher Hochschule Winterthur</p>
 * @author Samuel Beer
 * @version 1.0
 */

public class FrameSerie2
    extends JFrame {
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
  JButton jButtonStartA = new JButton();
  JButton jButtonStopA = new JButton();
  JLabel jLabelTitel = new JLabel();
  JLabel jLabelUntertitelA = new JLabel();
  JLabel jLabelBasis = new JLabel();
  JLabel jLabelExponent = new JLabel();
  JLabel jLabelModulus = new JLabel();
  JLabel jLabelErgAlg1 = new JLabel();
  JLabel jLabelErgAlg2 = new JLabel();
  JTextField jTextFieldBasis = new JTextField();
  JTextField jTextFieldExponent = new JTextField();
  JTextField jTextFieldModulusP = new JTextField();
  JTextField jTextFieldModulusQ = new JTextField();
  JTextArea jTextAreaErgAlg1 = new JTextArea();
  JTextArea jTextAreaErgAlg2 = new JTextArea();
  BigInteger basis = new BigInteger("1");
  BigInteger exponent = new BigInteger("1");
  BigInteger modulusP = new BigInteger("1");
  BigInteger modulusQ = new BigInteger("1");
  Serie2TestBerechnungenA testBerechnungenA = null;

// Elemente jPanel2
  JButton jButtonStartB = new JButton();
  JButton jButtonStopB = new JButton();
  JComboBox jComboBoxAnzWied;
  JLabel jLabelUntertitelB = new JLabel();
  JLabel jLabelAnzWied = new JLabel();
  JLabel jLabelAnzStellen = new JLabel();
  JLabel jLabelZeitAlg1 = new JLabel();
  JLabel jLabelZeitAlg2 = new JLabel();
  JLabel jLabelResAlg1 = new JLabel();
  JLabel jLabelResAlg2 = new JLabel();
  JTextArea jTextAreaZeitAlg1 = new JTextArea();
  JTextArea jTextAreaZeitAlg2 = new JTextArea();
  JTextField jTextFieldAnzStellen = new JTextField();
  JTextArea jTextAreaResAlg1 = new JTextArea();
  JTextArea jTextAreaResAlg2 = new JTextArea();
  String[] anzWiedStrings = {
      "1", "10", "100", "1000", "10000"};
  Serie2TestBerechnungenB testBerechnungenB = null;
  int anzStellen;
  int anzWiederholungen;

// Elemente jPanel3
  JButton jButtonLoeschen = new JButton();
  JButton jButtonStartC = new JButton();
  JButton jButtonStopC = new JButton();
  JComboBox jComboBoxLogLin;
  JLabel jLabelUntertitelC = new JLabel();
  JLabel jLabelLogLin = new JLabel();
  String[] logLinStrings = {
      "Lin", "Log"};
  Plot plot = new Plot();
  Serie2TestBerechnungenC testBerechnungenC = null;

  public FrameSerie2() {
    try {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
// Allgemeine Initialisierungen
    this.setSize(new Dimension(650, 900));
    this.setTitle("KryptoTrainer Testumgebung zum Praktikum 4.1");

// Menu
    jMenuDatei.setText("Datei");
    jMenuDateiSchliessen.setText("Schliessen");
    jMenuDateiSchliessen.addActionListener(new
                                           FrameSerie2_jMenuDateiSchliessen_actionAdapter(this));
    jMenuDatei.add(jMenuDateiSchliessen);

    jMenuBar1.add(jMenuDatei);
    this.setJMenuBar(jMenuBar1);

// Schriftart und Grösse für JTextArea Felder
    Font font = new Font(Font.MONOSPACED, Font.PLAIN, 13);
    
// Panel 1
    jPanel1.setLayout(null);
    jPanel1.setBackground(Color.white);
    jButtonStartA.setText("Start");
    jButtonStartA.setBounds(new Rectangle(496, 44, 62, 25));
    jButtonStartA.addActionListener(new FrameSerie2_jButtonStartA_actionAdapter(this));
    jButtonStopA.setBounds(new Rectangle(496, 70, 62, 25));
    jButtonStopA.setText("Stop");
    jButtonStopA.addActionListener(new FrameSerie2_jButtonStopA_actionAdapter(this));
    jLabelTitel.setFont(new java.awt.Font("Times New Roman", 1, 19));
    jLabelTitel.setHorizontalAlignment(SwingConstants.LEFT);
    jLabelTitel.setHorizontalTextPosition(SwingConstants.LEADING);
    jLabelTitel.setText("Testumgebung zur modularen Exponentiation mit Chin. Restsatz");
    jLabelTitel.setBounds(new Rectangle(1, 1, 580, 23));
    jLabelUntertitelA.setText("a) Ergebnisse im Vergleich");
    jLabelUntertitelA.setBounds(new Rectangle(9, 29, 255, 17));
    jLabelUntertitelA.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelBasis.setText("Basis");
    jLabelBasis.setBounds(new Rectangle(385, 51, 133, 15));
    jLabelExponent.setText("Exponent");
    jLabelExponent.setBounds(new Rectangle(385, 74, 133, 15));
    jLabelModulus.setText("Modulus");
    jLabelModulus.setBounds(new Rectangle(385, 96, 99, 15));
    jLabelErgAlg1.setText("Ergebnis Alg. 1 (myModPow)");
    jLabelErgAlg1.setBounds(new Rectangle(9, 114, 291, 15));
    jLabelErgAlg2.setText("Ergebnis Alg. 2 (modPow)");
    jLabelErgAlg2.setBounds(new Rectangle(9, 182, 373, 15));
    jTextFieldBasis.setText("" + basis);
    jTextFieldBasis.setBounds(new Rectangle(9, 48, 373, 21));
    jTextFieldBasis.addActionListener(new
                                      FrameSerie2_jTextFieldBasis_actionAdapter(this));
    jTextFieldBasis.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldBasis.setSelectionEnd(11);
    jTextFieldExponent.setText("" + exponent);
    jTextFieldExponent.setBounds(new Rectangle(9, 71, 373, 21));
    jTextFieldExponent.addActionListener(new
                                         FrameSerie2_jTextFieldExponent_actionAdapter(this));
    jTextFieldExponent.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldExponent.setSelectionEnd(11);
    jTextFieldModulusP.setText("" + modulusP);
    jTextFieldModulusP.setBounds(new Rectangle(9, 93, 179, 21));
    jTextFieldModulusP.addActionListener(new FrameSerie2_jTextFieldModulusP_actionAdapter(this));
    jTextFieldModulusP.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldModulusP.setSelectionEnd(11);
    jTextFieldModulusQ.setSelectionEnd(11);
    jTextFieldModulusQ.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldModulusQ.setBounds(new Rectangle(203, 93, 179, 21));
    jTextFieldModulusQ.addActionListener(new FrameSerie2_jTextFieldModulusQ_actionAdapter(this));
    jTextFieldModulusQ.setText("" + modulusQ);
    jTextAreaErgAlg1.setText("");
    jTextAreaErgAlg1.setBounds(new Rectangle(9, 130, 373, 47));
    jTextAreaErgAlg1.setEditable(false);
    jTextAreaErgAlg1.setBorder(BorderFactory.createEtchedBorder());
    jTextAreaErgAlg1.setBackground(Color.lightGray);
    jTextAreaErgAlg1.setFont(font);
    jTextAreaErgAlg1.setLineWrap(true);

    jTextAreaErgAlg2.setText("");
    jTextAreaErgAlg2.setBounds(new Rectangle(9, 198, 373, 47));
    jTextAreaErgAlg2.setEditable(false);
    jTextAreaErgAlg2.setBorder(BorderFactory.createEtchedBorder());
    jTextAreaErgAlg2.setBackground(Color.lightGray);
    jTextAreaErgAlg2.setFont(font);
    jTextAreaErgAlg2.setLineWrap(true);

    jPanel1.add(jButtonStartA, null);
    jPanel1.add(jLabelTitel, null);
    jPanel1.add(jLabelUntertitelA, null);
    jPanel1.add(jLabelBasis, null);
    jPanel1.add(jLabelExponent, null);
    jPanel1.add(jLabelModulus, null);
    jPanel1.add(jLabelErgAlg1, null);
    jPanel1.add(jLabelErgAlg2, null);
    jPanel1.add(jTextFieldBasis, null);
    jPanel1.add(jTextFieldExponent, null);
    jPanel1.add(jTextFieldModulusP, null);
    jPanel1.add(jTextAreaErgAlg1, null);
    jPanel1.add(jTextAreaErgAlg2, null);
    jPanel1.add(jButtonStopA, null);
    jPanel1.add(jTextFieldModulusQ, null);

// Panel 2
    anzStellen = 16;
    anzWiederholungen = Integer.valueOf(anzWiedStrings[0]).intValue();
    jPanel2.setLayout(null);
    jPanel2.setBackground(Color.white);
    jButtonStartB.setBounds(new Rectangle(496, 19, 62, 25));
    jButtonStartB.setText("Start");
    jButtonStartB.addActionListener(new FrameSerie2_jButtonStartB_actionAdapter(this));
    jButtonStopB.setBounds(new Rectangle(496, 45, 62, 25));
    jButtonStopB.setText("Stop");
    jButtonStopB.addActionListener(new FrameSerie2_jButtonStopB_actionAdapter(this));
    jComboBoxAnzWied = new JComboBox(anzWiedStrings);
    jComboBoxAnzWied.setBounds(new Rectangle(9, 49, 57, 21));
    jComboBoxAnzWied.addActionListener(new
                                       FrameSerie2_jComboBoxAnzWied_actionAdapter(this));
    jLabelUntertitelB.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelUntertitelB.setText("b) Ergebnis und Laufzeit im Vergleich");
    jLabelUntertitelB.setBounds(new Rectangle(9, 3, 255, 17));
    jLabelAnzWied.setText("Anzahl zufälliger Berechnungen");
    jLabelAnzWied.setBounds(new Rectangle(70, 52, 214, 15));
    jLabelAnzStellen.setText("Bitlänge der Zufallszahlen");
    jLabelAnzStellen.setBounds(new Rectangle(70, 26, 214, 15));
    jLabelZeitAlg1.setText("Rechenzeit Alg. 1 (myModPow)");
    jLabelZeitAlg1.setBounds(new Rectangle(389, 117, 202, 15));
    jLabelZeitAlg2.setText("Rechenzeit Alg. 2 (modPow)");
    jLabelZeitAlg2.setBounds(new Rectangle(389, 201, 202, 15));
    jLabelResAlg1.setText("Ergebnis der letzten Rechnung Alg. 1 (myModPow)");
    jLabelResAlg1.setBounds(new Rectangle(9, 80, 373, 15));
    jLabelResAlg2.setText("Ergebnis der letzten Rechnung Alg. 2 (modPow)");
    jLabelResAlg2.setBounds(new Rectangle(9, 158, 373, 15));
    jTextAreaZeitAlg1.setBackground(Color.lightGray);
    jTextAreaZeitAlg1.setEditable(false);
    jTextAreaZeitAlg1.setText("");
    jTextAreaZeitAlg1.setBounds(new Rectangle(389, 132, 131, 21));
    jTextAreaZeitAlg1.setFont(font);

    jTextAreaZeitAlg2.setBackground(Color.lightGray);
    jTextAreaZeitAlg2.setEditable(false);
    jTextAreaZeitAlg2.setText("");
    jTextAreaZeitAlg2.setBounds(new Rectangle(389, 216, 131, 21));
    jTextAreaZeitAlg2.setFont(font);

    jTextFieldAnzStellen.setSelectionEnd(11);
    jTextFieldAnzStellen.setText("" + anzStellen);
    jTextFieldAnzStellen.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldAnzStellen.setBounds(new Rectangle(9, 23, 57, 21));
    jTextFieldAnzStellen.addActionListener(new
                                           FrameSerie2_jTextFieldAnzStellen_actionAdapter(this));
    jTextAreaResAlg1.setBackground(Color.lightGray);
    jTextAreaResAlg1.setBorder(BorderFactory.createEtchedBorder());
    jTextAreaResAlg1.setEditable(false);
    jTextAreaResAlg1.setText("");
    jTextAreaResAlg1.setBounds(new Rectangle(9, 95, 373, 63));
    jTextAreaResAlg1.setFont(font);
    jTextAreaResAlg1.setLineWrap(true);

    jTextAreaResAlg2.setBackground(Color.lightGray);
    jTextAreaResAlg2.setBorder(BorderFactory.createEtchedBorder());
    jTextAreaResAlg2.setEditable(false);
    jTextAreaResAlg2.setText("");
    jTextAreaResAlg2.setBounds(new Rectangle(9, 174, 373, 63));
    jTextAreaResAlg2.setFont(font);
    jTextAreaResAlg2.setLineWrap(true);

    jPanel2.add(jButtonStartB, null);
    jPanel2.add(jButtonStopB, null);
    jPanel2.add(jComboBoxAnzWied, null);
    jPanel2.add(jLabelUntertitelB, null);
    jPanel2.add(jLabelAnzStellen, null);
    jPanel2.add(jLabelAnzWied, null);
    jPanel2.add(jLabelResAlg1, null);
    jPanel2.add(jLabelResAlg2, null);
        jPanel2.add(jTextAreaZeitAlg1, null);
    jPanel2.add(jTextAreaZeitAlg2, null);
    jPanel2.add(jTextFieldAnzStellen, null);
    jPanel2.add(jTextAreaResAlg1, null);
    jPanel2.add(jTextAreaResAlg2, null);
        jPanel2.add(jLabelZeitAlg1, null);
        jPanel2.add(jLabelZeitAlg2, null);

        // Panel 3
    jPanel3.setLayout(null);
    jPanel3.setBackground(Color.white);
    jPanel3.setOpaque(true);
    jButtonStartC.setText("Start");
    jButtonStartC.setBounds(new Rectangle(496, 20, 62, 25));
    jButtonStartC.addActionListener(new FrameSerie2_jButtonStartC_actionAdapter(this));
    jButtonStopC.setBounds(new Rectangle(496, 1, 62, 25));
    jButtonStopC.setText("Stop");
    jButtonStopC.addActionListener(new FrameSerie2_jButtonStopC_actionAdapter(this));
    jButtonLoeschen.setText("Löschen");
    jButtonLoeschen.setBounds(new Rectangle(380, 20, 97, 25));
    jButtonLoeschen.addActionListener(new
                                      FrameSerie2_jButtonLoeschen_actionAdapter(this));
    jComboBoxLogLin = new JComboBox(logLinStrings);
    jComboBoxLogLin.setBounds(new Rectangle(8, 24, 46, 21));
    jComboBoxLogLin.addActionListener(new
                                      FrameSerie2_jComboBoxLogLin_actionAdapter(this));
    jLabelUntertitelC.setText("c) Graphische Auswertung der Laufzeit");
    jLabelUntertitelC.setBounds(new Rectangle(8, 0, 270, 17));
    jLabelUntertitelC.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelLogLin.setText("Skalierung der y-Achse");
    jLabelLogLin.setBounds(new Rectangle(58, 27, 213, 15));
    plot.setBounds(new Rectangle(0, 45, 598, 204));

    jPanel3.add(jButtonLoeschen, null);
    jPanel3.add(jComboBoxLogLin, null);
    jPanel3.add(jLabelUntertitelC, null);
    jPanel3.add(jLabelLogLin, null);
    jPanel3.add(plot, null);
    jPanel3.add(jButtonStartC, null);
    plot.add(jButtonStopC, null);
    GraphikLoeschen();

// ContentPane
    contentPane = (JPanel)this.getContentPane();
    contentPane.setMinimumSize(new Dimension(600, 800));
    contentPane.setPreferredSize(new Dimension(600, 800));
    gridLayoutContentPane.setColumns(1);
    gridLayoutContentPane.setRows(3);
    contentPane.setLayout(gridLayoutContentPane);

    contentPane.add(jPanel1, null);
    contentPane.add(jPanel2, null);
    contentPane.add(jPanel3, null);
  }

// Konstanten für die Grafik der Testberechnungen Teil (c)
  boolean logYAchse = false;
  final int ZEIT_SCHWELLE_GRAPH = 500; // Zeit in ms
  final int MAX_BERECHNUNGEN_GRAPH = 256;
  final int MIN_BIT_LAENGE_GRAPH = 128;
  final int MAX_BIT_LAENGE_GRAPH = 2048;
  final int MAX_Y_ACHSE_GRAPH = 40; // Zeit in ms
  final int MIN_Y_ACHSE_LOG_GRAPH = 0;
  final int MAX_Y_ACHSE_LOG_GRAPH = 3;

  void GraphikLoeschen() {
    int i;

    plot.clear(true);
    plot.setBackground(Color.white);
    plot.setLayout(null);
    plot.setXRange(0, MAX_BIT_LAENGE_GRAPH);
    plot.setXLabel("Bitlänge");
    for (i = 0; i <= MAX_BIT_LAENGE_GRAPH; i = i + 2 * MIN_BIT_LAENGE_GRAPH) {
      plot.addXTick("" + i, i);
    }
    if (logYAchse == true) {
      plot.setYLog(true);
      plot.setYRange(MIN_Y_ACHSE_LOG_GRAPH, MAX_Y_ACHSE_LOG_GRAPH);
    }
    else {
      plot.setYRange(0, MAX_Y_ACHSE_GRAPH);
      for (i = 0; i <= MAX_Y_ACHSE_GRAPH; i = i + MAX_Y_ACHSE_GRAPH / 5) {
        plot.addYTick("" + i, i);
      }
    }
    plot.setYLabel("Zeit / [ms]");
    plot.setMarksStyle("none");
    plot.addLegend(0, "Alg. 1");
    plot.addLegend(1, "Alg. 2");
    plot.repaint();
  }

  void jButtonStartA_actionPerformed(ActionEvent e) {
    updateFields();

    // Thread für Testberechnungen starten
    if (testBerechnungenA != null) {
      if (testBerechnungenA.isAlive()) {
        return;
      }
    }
    testBerechnungenA = new Serie2TestBerechnungenA(jTextAreaErgAlg1,
                                                jTextAreaErgAlg2,
                                                basis, exponent,
                                                modulusP, modulusQ);
    testBerechnungenA.start();
  }

  void jButtonStopA_actionPerformed(ActionEvent e) {
    updateFields();

    // Thread für Testberechnungen abschiessen
    if (testBerechnungenA != null) {
      testBerechnungenA.stop();
    }
  }

  void jButtonStartB_actionPerformed(ActionEvent e) {
    updateFields();

    // Thread für Testberechnungen starten
    if (testBerechnungenB != null) {
      if (testBerechnungenB.isAlive()) {
        return;
      }
    }
    testBerechnungenB = new Serie2TestBerechnungenB(jTextAreaZeitAlg1,
                                                jTextAreaResAlg1,
                                                jTextAreaZeitAlg2,
                                                jTextAreaResAlg2,
                                                anzWiederholungen, anzStellen);
    testBerechnungenB.start();
  }

  void jButtonStopB_actionPerformed(ActionEvent e) {
    updateFields();

    // Thread für Testberechnungen abschiessen
    if (testBerechnungenB != null) {
      testBerechnungenB.stop();
    }
  }

  void jButtonStartC_actionPerformed(ActionEvent e) {
    updateFields();

    // Thread für Testberechnungen starten
    if (testBerechnungenC != null) {
      if (testBerechnungenC.isAlive()) {
        return;
      }
    }
    testBerechnungenC = new Serie2TestBerechnungenC(plot,
                                                MAX_BERECHNUNGEN_GRAPH,
                                                MIN_BIT_LAENGE_GRAPH,
                                                MAX_BIT_LAENGE_GRAPH,
                                                ZEIT_SCHWELLE_GRAPH);
    testBerechnungenC.start();
  }

  void jButtonStopC_actionPerformed(ActionEvent e) {
    updateFields();

    // Thread für Testberechnungen abschiessen
    if (testBerechnungenC != null) {
      testBerechnungenC.stop();
    }
  }

  void jButtonLoeschen_actionPerformed(ActionEvent e) {
    updateFields();

    // Thread für Testberechnungen abschiessen
    if (testBerechnungenC != null) {
      testBerechnungenC.stop();
    }
    GraphikLoeschen();
  }

  void jComboBoxAnzWied_actionPerformed(ActionEvent e) {
    updateFields();
    JComboBox cb = (JComboBox) e.getSource();
    String str = (String) cb.getSelectedItem();
    anzWiederholungen = Integer.valueOf(str).intValue();
  }

  void jComboBoxLogLin_actionPerformed(ActionEvent e) {
    updateFields();
    JComboBox cb = (JComboBox) e.getSource();
    String str = (String) cb.getSelectedItem();
    if (str == "Log") {
      logYAchse = true;
    }
    else {
      logYAchse = false;
    }

    // Thread für Testberechnungen abschiessen
    if (testBerechnungenC != null) {
      testBerechnungenC.stop();
    }
    GraphikLoeschen();
  }

  void jMenuDateiSchliessen_actionPerformed(ActionEvent e) {
    this.dispose();
  }

  void jTextFieldAnzStellen_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldAnzStellen.selectAll();
  }

  void jTextFieldBasis_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldBasis.selectAll();
  }

  void jTextFieldExponent_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldExponent.selectAll();
  }

  void jTextFieldModulusP_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldModulusP.selectAll();
  }

  void jTextFieldModulusQ_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldModulusQ.selectAll();
  }

  void updateFields() {
    anzStellen = Integer.valueOf(jTextFieldAnzStellen.getText()).intValue();
    basis = new BigInteger(jTextFieldBasis.getText());
    exponent = new BigInteger(jTextFieldExponent.getText());
    modulusP = new BigInteger(jTextFieldModulusP.getText());
    modulusQ = new BigInteger(jTextFieldModulusQ.getText());
  }
}

class FrameSerie2_jMenuDateiSchliessen_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie2 adaptee;

  FrameSerie2_jMenuDateiSchliessen_actionAdapter(FrameSerie2 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuDateiSchliessen_actionPerformed(e);
  }
}

class FrameSerie2_jTextFieldAnzStellen_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie2 adaptee;

  FrameSerie2_jTextFieldAnzStellen_actionAdapter(FrameSerie2 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldAnzStellen_actionPerformed(e);
  }
}

class FrameSerie2_jComboBoxAnzWied_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie2 adaptee;

  FrameSerie2_jComboBoxAnzWied_actionAdapter(FrameSerie2 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jComboBoxAnzWied_actionPerformed(e);
  }
}

class FrameSerie2_jButtonStartB_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie2 adaptee;

  FrameSerie2_jButtonStartB_actionAdapter(FrameSerie2 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartB_actionPerformed(e);
  }
}

class FrameSerie2_jButtonStartC_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie2 adaptee;

  FrameSerie2_jButtonStartC_actionAdapter(FrameSerie2 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartC_actionPerformed(e);
  }
}

class FrameSerie2_jButtonLoeschen_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie2 adaptee;

  FrameSerie2_jButtonLoeschen_actionAdapter(FrameSerie2 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonLoeschen_actionPerformed(e);
  }
}

class FrameSerie2_jComboBoxLogLin_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie2 adaptee;

  FrameSerie2_jComboBoxLogLin_actionAdapter(FrameSerie2 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jComboBoxLogLin_actionPerformed(e);
  }
}

class FrameSerie2_jButtonStartA_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie2 adaptee;

  FrameSerie2_jButtonStartA_actionAdapter(FrameSerie2 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartA_actionPerformed(e);
  }
}

class FrameSerie2_jTextFieldExponent_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie2 adaptee;

  FrameSerie2_jTextFieldExponent_actionAdapter(FrameSerie2 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldExponent_actionPerformed(e);
  }
}

class FrameSerie2_jTextFieldBasis_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie2 adaptee;

  FrameSerie2_jTextFieldBasis_actionAdapter(FrameSerie2 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldBasis_actionPerformed(e);
  }
}

class FrameSerie2_jTextFieldModulusP_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie2 adaptee;

  FrameSerie2_jTextFieldModulusP_actionAdapter(FrameSerie2 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldModulusP_actionPerformed(e);
  }
}

class FrameSerie2_jTextFieldModulusQ_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie2 adaptee;

  FrameSerie2_jTextFieldModulusQ_actionAdapter(FrameSerie2 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldModulusQ_actionPerformed(e);
  }
}

class FrameSerie2_jButtonStopA_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie2 adaptee;

  FrameSerie2_jButtonStopA_actionAdapter(FrameSerie2 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStopA_actionPerformed(e);
  }
}

class FrameSerie2_jButtonStopB_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie2 adaptee;

  FrameSerie2_jButtonStopB_actionAdapter(FrameSerie2 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStopB_actionPerformed(e);
  }
}

class FrameSerie2_jButtonStopC_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie2 adaptee;

  FrameSerie2_jButtonStopC_actionAdapter(FrameSerie2 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStopC_actionPerformed(e);
  }
}

class Serie2TestBerechnungenA
    extends Thread {
  JTextArea ergAlg1, ergAlg2;
  BigInteger basis, exponent, modulusP, modulusQ;

  Serie2TestBerechnungenA(JTextArea ergAlg1, JTextArea ergAlg2,
                     BigInteger basis, BigInteger exponent,
                     BigInteger modulusP, BigInteger modulusQ) {
    this.ergAlg1 = ergAlg1;
    this.ergAlg2 = ergAlg2;
    this.basis = basis;
    this.exponent = exponent;
    this.modulusP = modulusP;
    this.modulusQ = modulusQ;
    this.setPriority(this.getPriority() - 1);
  }

  public void run() {
    BigInteger erg;

    // Berechnungen mit myModPow()
    erg = basis;
    erg = erg.myModPow(exponent, modulusP, modulusQ);
    ergAlg1.setText(erg.toString());

    // Berechnungen mit modPow()
    erg = basis;
    erg = erg.modPow(exponent, modulusP.multiply(modulusQ));
    ergAlg2.setText(erg.toString());
  }
}

class Serie2TestBerechnungenB
    extends Thread {
  JTextArea zeitAlg1, zeitAlg2;
  JTextArea resAlg1, resAlg2;
  int anzWiederholungen, anzStellen;

  Serie2TestBerechnungenB(JTextArea zeitAlg1, JTextArea resAlg1,
                     JTextArea zeitAlg2, JTextArea resAlg2,
                     int anzWiederholungen, int anzStellen) {
    this.zeitAlg1 = zeitAlg1;
    this.zeitAlg2 = zeitAlg2;
    this.resAlg1 = resAlg1;
    this.resAlg2 = resAlg2;
    this.anzWiederholungen = anzWiederholungen;
    this.anzStellen = anzStellen;
    this.setPriority(this.getPriority() - 1);
  }

  public void run() {
    int i;
    BigInteger n = new BigInteger("0");
    BigInteger p = new BigInteger("0");
    BigInteger mp = new BigInteger("0");
    BigInteger mq = new BigInteger("0");
    BigInteger m = new BigInteger("0");
    Random rnd = new Random();
    BigInteger[] numArrayN = new BigInteger[anzWiederholungen];
    BigInteger[] numArrayP = new BigInteger[anzWiederholungen];
    Time zeitStempelAnf;
    Time zeitStempelEnd;

    // Modulus generieren
    mp = new BigInteger(anzStellen/2, 8, rnd);
    mq = new BigInteger(anzStellen/2, 8, rnd);
    while (mp.equals(mq)) {
      mq = new BigInteger(anzStellen/2, 8, rnd);
    }
    m = mp.multiply(mq);
    
    // Zahlenpaare generieren
    for (i = 0; i < anzWiederholungen; i++) {
      n = new BigInteger(anzStellen, rnd);
      numArrayN[i] = n;
      p = new BigInteger(anzStellen, rnd);
      numArrayP[i] = p;
    }

    // Berechnungen mit myModPow()
    zeitStempelAnf = new Time(System.currentTimeMillis());
    for (i = 0; i < anzWiederholungen; i++) {
      n = numArrayN[i];
      p = numArrayP[i];
      n = n.myModPow(p, mp, mq);
    }
    zeitStempelEnd = new Time(System.currentTimeMillis());
    zeitAlg1.setText("" + (zeitStempelEnd.getTime() - zeitStempelAnf.getTime()) +
                     " ms");
    resAlg1.setText(n.toString());

    // Berechnungen mit modPow()
    zeitStempelAnf = new Time(System.currentTimeMillis());
    for (i = 0; i < anzWiederholungen; i++) {
      n = numArrayN[i];
      p = numArrayP[i];
      n = n.modPow(p, m);
    }
    zeitStempelEnd = new Time(System.currentTimeMillis());
    zeitAlg2.setText("" + (zeitStempelEnd.getTime() - zeitStempelAnf.getTime()) +
                     " ms");
    resAlg2.setText(n.toString());
  }
}

class Serie2TestBerechnungenC
    extends Thread {
  Plot plot;
  int maxBerechnungenGraph, minBitLaengeGraph, maxBitLaengeGraph, zeitSchwelleGraph;

  Serie2TestBerechnungenC(Plot plot, int maxBerechnungenGraph, int minBitLaengeGraph,
                     int maxBitLaengeGraph, int zeitSchwelleGraph) {
    this.plot = plot;
    this.maxBerechnungenGraph = maxBerechnungenGraph;
    this.minBitLaengeGraph = minBitLaengeGraph;
    this.maxBitLaengeGraph = maxBitLaengeGraph;
    this.zeitSchwelleGraph = zeitSchwelleGraph;
    this.setPriority(this.getPriority() - 1);
  }

  public void run() {
    int i, k;
    int anzBerechnungenGraph0 = maxBerechnungenGraph;
    int anzBerechnungenGraph1 = maxBerechnungenGraph;
    int anzBerechnungenMax;
    double zeit;
    BigInteger n = new BigInteger("0");
    BigInteger p = new BigInteger("0");
    BigInteger mp = new BigInteger("0");
    BigInteger mq = new BigInteger("0");
    BigInteger m = new BigInteger("0");
    Random rnd = new Random();
    BigInteger[] numArrayN = new BigInteger[maxBerechnungenGraph];
    BigInteger[] numArrayP = new BigInteger[maxBerechnungenGraph];
    Time zeitStempelAnf;
    Time zeitStempelEnd;
    boolean ersterPunktGraph0 = true;
    boolean ersterPunktGraph1 = true;

    // Bitlanege sukzessive erhoehen
    for (i = minBitLaengeGraph; i <= maxBitLaengeGraph;
         i = i + minBitLaengeGraph) {

      // Zahlenpaare generieren
      anzBerechnungenMax = Math.max(anzBerechnungenGraph0,
                                    anzBerechnungenGraph1);
      for (k = 0; k < anzBerechnungenMax; k++) {
        n = new BigInteger(i, rnd);
        numArrayN[k] = n;
        p = new BigInteger(i, rnd);
        numArrayP[k] = p;
      }
      // Pro Bitlänge immer den gleichen Modulus!
      mp = new BigInteger(i/2, 8, rnd);
      mq = new BigInteger(i/2, 8, rnd);
      m = mp.multiply(mq);

      // Berechnungen mit myModPow()
      zeitStempelAnf = new Time(System.currentTimeMillis());
      for (k = 0; k < anzBerechnungenGraph0; k++) {
        n = numArrayN[k];
        p = numArrayP[k];
        n = n.myModPow(p, mp, mq);
      }
      zeitStempelEnd = new Time(System.currentTimeMillis());
      zeit = zeitStempelEnd.getTime() - zeitStempelAnf.getTime();
      plot.addPoint(0, i, zeit / anzBerechnungenGraph0, !ersterPunktGraph0);
      ersterPunktGraph0 = false;
      if ( (zeit >= zeitSchwelleGraph) && (anzBerechnungenGraph0 > 1)) {
        anzBerechnungenGraph0 = anzBerechnungenGraph0 / 2;
      }

      // Berechnungen mit modPow()
      zeitStempelAnf = new Time(System.currentTimeMillis());
      for (k = 0; k < anzBerechnungenGraph1; k++) {
        n = numArrayN[k];
        p = numArrayP[k];
        n = n.modPow(p, m);
      }
      zeitStempelEnd = new Time(System.currentTimeMillis());
      zeit = (zeitStempelEnd.getTime() - zeitStempelAnf.getTime());
      plot.addPoint(1, i, zeit / anzBerechnungenGraph1, !ersterPunktGraph1);
      ersterPunktGraph1 = false;
      // Zeitschwelle pruefen
      if ( (zeit >= zeitSchwelleGraph) && (anzBerechnungenGraph1 > 1)) {
        anzBerechnungenGraph1 = anzBerechnungenGraph1 / 2;
      }
    }
  }
}
