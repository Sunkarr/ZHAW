package kryptotrainer;

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

/**
 * Testumgebung für Multiplikations-Algorithmen
 */
public class FrameSerieX extends JFrame {
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
  JLabel jLabelTitel = new JLabel();
  JLabel jLabelUntertitelA = new JLabel();
  JLabel jLabelFaktorA = new JLabel();
  JLabel jLabelFaktorB = new JLabel();
  JLabel jLabelErgAlg1 = new JLabel();
  JLabel jLabelErgAlg2 = new JLabel();
  JTextField jTextFieldFaktorA = new JTextField();
  JTextField jTextFieldFaktorB = new JTextField();
  JTextPane jTextPaneErgAlg1 = new JTextPane();
  JTextPane jTextPaneErgAlg2 = new JTextPane();
  BigInteger faktorA = new BigInteger("0");
  BigInteger faktorB = new BigInteger("0");


// Elemente jPanel2
  JButton jButtonStartB = new JButton();
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
  JTextPane jTextPaneResAlg1 = new JTextPane();
  JTextPane jTextPaneResAlg2 = new JTextPane();
  String[] anzWiedStrings = {"1", "10", "100", "1000", "10000"};
  int anzStellen;
  int anzWiederholungen;

// Elemente jPanel3
  JButton jButtonLoeschen = new JButton();
  JButton jButtonStartC = new JButton();
  JComboBox jComboBoxLogLin;
  JLabel jLabelUntertitelC = new JLabel();
  JLabel jLabelLogLin = new JLabel();
  String[] logLinStrings = {"Lin", "Log"};
  Plot plot = new Plot();

  public FrameSerieX() {
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
    this.setTitle("KryptoTrainer Testumgebung zu Serie 2");

// Menu
    jMenuDatei.setText("Datei");
    jMenuDateiSchliessen.setText("Schliessen");
    jMenuDateiSchliessen.addActionListener(new FrameSerieX_jMenuDateiSchliessen_actionAdapter(this));
    jMenuDatei.add(jMenuDateiSchliessen);

    jMenuBar1.add(jMenuDatei);
    this.setJMenuBar(jMenuBar1);

// Panel 1
    jPanel1.setLayout(null);
    jPanel1.setBackground(Color.white);
    jButtonStartA.setText("Start");
    jButtonStartA.setBounds(new Rectangle(496, 68, 62, 25));
    jButtonStartA.addActionListener(new FrameSerieX_jButtonStartA_actionAdapter(this));
    jLabelTitel.setFont(new java.awt.Font("Times New Roman", 1, 19));
    jLabelTitel.setHorizontalAlignment(SwingConstants.LEFT);
    jLabelTitel.setHorizontalTextPosition(SwingConstants.LEADING);
    jLabelTitel.setText("Testumgebung zu Serie 2 (Multiplikation)");
    jLabelTitel.setBounds(new Rectangle(1, 1, 564, 23));
    jLabelUntertitelA.setText("a) Ergebnisse im Vergleich");
    jLabelUntertitelA.setBounds(new Rectangle(9, 29, 255, 17));
    jLabelUntertitelA.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelFaktorA.setText("Faktor a");
    jLabelFaktorA.setBounds(new Rectangle(385, 51, 133, 15));
    jLabelFaktorB.setText("Faktor b");
    jLabelFaktorB.setBounds(new Rectangle(385, 75, 133, 15));
    jLabelErgAlg1.setText("Ergebnis Alg. 1 (myMultiply)");
    jLabelErgAlg1.setBounds(new Rectangle(9, 94, 291, 15));
    jLabelErgAlg2.setText("Ergebnis Alg. 2 (multiply)");
    jLabelErgAlg2.setBounds(new Rectangle(9, 171, 373, 15));
    jTextFieldFaktorA.setText("" + faktorA);
    jTextFieldFaktorA.setBounds(new Rectangle(9, 48, 373, 21));
    jTextFieldFaktorA.addActionListener(new FrameSerieX_jTextFieldFaktorA_actionAdapter(this));
    jTextFieldFaktorA.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldFaktorA.setSelectionEnd(11);
    jTextFieldFaktorB.setText("" + faktorB);
    jTextFieldFaktorB.setBounds(new Rectangle(9, 72, 373, 21));
    jTextFieldFaktorB.addActionListener(new FrameSerieX_jTextFieldFaktorB_actionAdapter(this));
    jTextFieldFaktorB.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldFaktorB.setSelectionEnd(11);
    jTextPaneErgAlg1.setText("");
    jTextPaneErgAlg1.setBounds(new Rectangle(9, 110, 373, 61));
    jTextPaneErgAlg1.setEditable(false);
    jTextPaneErgAlg1.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneErgAlg1.setBackground(Color.lightGray);
    jTextPaneErgAlg2.setText("");
    jTextPaneErgAlg2.setBounds(new Rectangle(9, 187, 373, 61));
    jTextPaneErgAlg2.setEditable(false);
    jTextPaneErgAlg2.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneErgAlg2.setBackground(Color.lightGray);

    jPanel1.add(jButtonStartA, null);
    jPanel1.add(jLabelTitel, null);
    jPanel1.add(jLabelUntertitelA, null);
    jPanel1.add(jLabelFaktorA, null);
    jPanel1.add(jLabelFaktorB, null);
    jPanel1.add(jTextFieldFaktorA, null);
    jPanel1.add(jTextFieldFaktorB, null);
    jPanel1.add(jTextPaneErgAlg1, null);
    jPanel1.add(jLabelErgAlg1, null);
    jPanel1.add(jTextPaneErgAlg2, null);
    jPanel1.add(jLabelErgAlg2, null);

// Panel 2
    anzStellen = 16;
    anzWiederholungen = Integer.valueOf(anzWiedStrings[0]).intValue();
    jPanel2.setLayout(null);
    jPanel2.setBackground(Color.white);
    jButtonStartB.setBounds(new Rectangle(496, 45, 62, 25));
    jButtonStartB.setText("Start");
    jButtonStartB.addActionListener(new FrameSerieX_jButtonStartB_actionAdapter(this));
    jComboBoxAnzWied = new JComboBox(anzWiedStrings);
    jComboBoxAnzWied.setBounds(new Rectangle(9, 49, 57, 21));
    jComboBoxAnzWied.addActionListener(new FrameSerieX_jComboBoxAnzWied_actionAdapter(this));
    jLabelUntertitelB.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelUntertitelB.setText("b) Ergebnis und Laufzeit im Vergleich");
    jLabelUntertitelB.setBounds(new Rectangle(9, 3, 255, 17));
    jLabelAnzWied.setText("Anzahl zufälliger Berechnungen");
    jLabelAnzWied.setBounds(new Rectangle(70, 52, 161, 15));
    jLabelAnzStellen.setText("Bitlänge der Zufallszahlen");
    jLabelAnzStellen.setBounds(new Rectangle(70, 26, 133, 15));
    jLabelZeitAlg1.setText("Rechenzeit Alg. 1 (myMultiply)");
    jLabelZeitAlg1.setBounds(new Rectangle(389, 121, 158, 15));
    jLabelZeitAlg2.setText("Rechenzeit Alg. 2 (multiply)");
    jLabelZeitAlg2.setBounds(new Rectangle(389, 205, 145, 15));
    jLabelResAlg1.setText("Ergebnis der letzten Rechnung Alg. 1 (myMultiply)");
    jLabelResAlg1.setBounds(new Rectangle(9, 80, 373, 15));
    jLabelResAlg2.setText("Ergebnis der letzten Rechnung Alg. 2 (multiply)");
    jLabelResAlg2.setBounds(new Rectangle(9, 158, 373, 15));
    jTextAreaZeitAlg1.setBackground(Color.lightGray);
    jTextAreaZeitAlg1.setEditable(false);
    jTextAreaZeitAlg1.setText("");
    jTextAreaZeitAlg1.setBounds(new Rectangle(389, 136, 131, 17));
    jTextAreaZeitAlg2.setBackground(Color.lightGray);
    jTextAreaZeitAlg2.setEditable(false);
    jTextAreaZeitAlg2.setText("");
    jTextAreaZeitAlg2.setBounds(new Rectangle(389, 220, 131, 17));
    jTextFieldAnzStellen.setSelectionEnd(11);
    jTextFieldAnzStellen.setText("" + anzStellen);
    jTextFieldAnzStellen.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldAnzStellen.setBounds(new Rectangle(9, 23, 57, 21));
    jTextFieldAnzStellen.addActionListener(new FrameSerieX_jTextFieldAnzStellen_actionAdapter(this));
    jTextPaneResAlg1.setBackground(Color.lightGray);
    jTextPaneResAlg1.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneResAlg1.setEditable(false);
    jTextPaneResAlg1.setText("");
    jTextPaneResAlg1.setBounds(new Rectangle(9, 95, 373, 63));
    jTextPaneResAlg2.setBackground(Color.lightGray);
    jTextPaneResAlg2.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneResAlg2.setEditable(false);
    jTextPaneResAlg2.setText("");
    jTextPaneResAlg2.setBounds(new Rectangle(9, 174, 373, 63));

    jPanel2.add(jButtonStartB, null);
    jPanel2.add(jComboBoxAnzWied, null);
    jPanel2.add(jLabelUntertitelB, null);
    jPanel2.add(jLabelAnzStellen, null);
    jPanel2.add(jLabelAnzWied, null);
    jPanel2.add(jLabelResAlg1, null);
    jPanel2.add(jLabelResAlg2, null);
    jPanel2.add(jLabelZeitAlg1, null);
    jPanel2.add(jLabelZeitAlg2, null);
    jPanel2.add(jTextAreaZeitAlg1, null);
    jPanel2.add(jTextAreaZeitAlg2, null);
    jPanel2.add(jTextFieldAnzStellen, null);
    jPanel2.add(jTextPaneResAlg1, null);
    jPanel2.add(jTextPaneResAlg2, null);

// Panel 3
    jPanel3.setLayout(null);
    jPanel3.setBackground(Color.white);
    jPanel3.setOpaque(true);
    jButtonStartC.setText("Start");
    jButtonStartC.setBounds(new Rectangle(496, 20, 62, 25));
    jButtonStartC.addActionListener(new FrameSerieX_jButtonStartC_actionAdapter(this));
    jButtonLoeschen.setText("Löschen");
    jButtonLoeschen.setBounds(new Rectangle(400, 20, 77, 25));
    jButtonLoeschen.addActionListener(new FrameSerieX_jButtonLoeschen_actionAdapter(this));
    jComboBoxLogLin = new JComboBox(logLinStrings);
    jComboBoxLogLin.setBounds(new Rectangle(8, 24, 46, 21));
    jComboBoxLogLin.addActionListener(new FrameSerieX_jComboBoxLogLin_actionAdapter(this));
    jLabelUntertitelC.setText("c) Graphische Auswertung der Laufzeit");
    jLabelUntertitelC.setBounds(new Rectangle(8, 0, 270, 17));
    jLabelUntertitelC.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelLogLin.setText("Skalierung der y-Achse");
    jLabelLogLin.setBounds(new Rectangle(58, 27, 124, 15));
    plot.setBounds(new Rectangle(0, 45, 598, 204));

    jPanel3.add(jButtonLoeschen, null);
    jPanel3.add(jButtonStartC, null);
    jPanel3.add(jComboBoxLogLin, null);
    jPanel3.add(jLabelUntertitelC, null);
    jPanel3.add(jLabelLogLin, null);
    jPanel3.add(plot, null);
    GraphikLoeschen();

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

// Testberechnungen Teil (a)
  void TestBerechnungenA() {
    BigInteger prod;

    // Berechnungen mit myMultiply()
    prod = faktorA;
    prod = prod.myMultiply(faktorB);
    jTextPaneErgAlg1.setText(prod.toString());

    // Berechnungen mit multiply()
    prod = faktorA;
    prod = prod.multiply(faktorB);
    jTextPaneErgAlg2.setText(prod.toString());
  }

// Testberechnungen Teil (b)
  void TestBerechnungenB() {
    int i;
    BigInteger n = new BigInteger("0");
    BigInteger m = new BigInteger("0");
    Random rnd = new Random();
    BigInteger[] numArrayN = new BigInteger[anzWiederholungen];
    BigInteger[] numArrayM = new BigInteger[anzWiederholungen];
    Time zeitStempelAnf;
    Time zeitStempelEnd;

    // Zahlenpaare generieren
    for (i = 0; i < anzWiederholungen; i++) {
      n = new BigInteger(anzStellen, rnd);
      numArrayN[i] = n;
      m = new BigInteger(anzStellen, rnd);
      numArrayM[i] = m;
    }

    // Berechnungen mit myMultiply()
    zeitStempelAnf = new Time(System.currentTimeMillis());
    for (i = 0; i < anzWiederholungen; i++) {
      n = numArrayN[i];
      m = numArrayM[i];
      n = n.myMultiply(m);
    }
    zeitStempelEnd = new Time(System.currentTimeMillis());
    jTextAreaZeitAlg1.setText("" + (zeitStempelEnd.getTime()-zeitStempelAnf.getTime()) + " ms");
    jTextPaneResAlg1.setText(n.toString());

    // Berechnungen mit multiply()
    zeitStempelAnf = new Time(System.currentTimeMillis());
    for (i = 0; i < anzWiederholungen; i++) {
      n = numArrayN[i];
      m = numArrayM[i];
      n = n.multiply(m);
    }
    zeitStempelEnd = new Time(System.currentTimeMillis());
    jTextAreaZeitAlg2.setText("" + (zeitStempelEnd.getTime()-zeitStempelAnf.getTime()) + " ms");
    jTextPaneResAlg2.setText(n.toString());
  }

// Testberechnungen Teil (c)
  boolean logYAchse = false;
  final int ZEIT_SCHWELLE_GRAPH = 500;        // Zeit in ms
  final int MAX_BERECHNUNGEN_GRAPH = 8192;
  final int MIN_BIT_LAENGE_GRAPH = 128;
  final int MAX_BIT_LAENGE_GRAPH = 2048;
  final int MAX_Y_ACHSE_GRAPH = 150;          // Zeit in ns
  final int MIN_Y_ACHSE_LOG_GRAPH = 0;
  final int MAX_Y_ACHSE_LOG_GRAPH = 3;

  void TestBerechnungenC() {
    int i, k;
    int anzBerechnungenGraph0 = MAX_BERECHNUNGEN_GRAPH;
    int anzBerechnungenGraph1 = MAX_BERECHNUNGEN_GRAPH;
    int anzBerechnungenMax;
    double zeit;
    BigInteger n = new BigInteger("0");
    BigInteger m = new BigInteger("0");
    Random rnd = new Random();
    BigInteger[] numArrayN = new BigInteger[MAX_BERECHNUNGEN_GRAPH];
    BigInteger[] numArrayM = new BigInteger[MAX_BERECHNUNGEN_GRAPH];
    Time zeitStempelAnf;
    Time zeitStempelEnd;
    boolean ersterPunktGraph0 = true;
    boolean ersterPunktGraph1 = true;

    // Bitlanege sukzessive erhoehen
    for (i=MIN_BIT_LAENGE_GRAPH; i<=MAX_BIT_LAENGE_GRAPH; i=i+MIN_BIT_LAENGE_GRAPH) {

      // Zahlenpaare generieren
      anzBerechnungenMax = Math.max(anzBerechnungenGraph0, anzBerechnungenGraph1);
      for (k = 0; k < anzBerechnungenMax; k++) {
        n = new BigInteger(i, rnd);
        numArrayN[k] = n;
        m = new BigInteger(i, rnd);
        numArrayM[k] = m;
      }

      // Berechnungen mit myMultiply()
      zeitStempelAnf = new Time(System.currentTimeMillis());
      for (k = 0; k < anzBerechnungenGraph0; k++) {
        n = numArrayN[k];
        m = numArrayM[k];
        n = n.myMultiply(m);
      }
      zeitStempelEnd = new Time(System.currentTimeMillis());
      zeit = zeitStempelEnd.getTime()-zeitStempelAnf.getTime();
      plot.addPoint(0, i, 1000*zeit/anzBerechnungenGraph0, !ersterPunktGraph0);
      ersterPunktGraph0 = false;
      if ((zeit >= ZEIT_SCHWELLE_GRAPH) && (anzBerechnungenGraph0 > 1)) {
          anzBerechnungenGraph0 = anzBerechnungenGraph0/2;
      }

      // Berechnungen mit multiply()
      zeitStempelAnf = new Time(System.currentTimeMillis());
      for (k = 0; k < anzBerechnungenGraph1; k++) {
        n = numArrayN[k];
        m = numArrayM[k];
        n = n.multiply(m);
      }
      zeitStempelEnd = new Time(System.currentTimeMillis());
      zeit = (zeitStempelEnd.getTime()-zeitStempelAnf.getTime());
      plot.addPoint(1, i, 1000*zeit/anzBerechnungenGraph1, !ersterPunktGraph1);
      ersterPunktGraph1 = false;
      // Zeitschwelle pruefen
      if ((zeit >= ZEIT_SCHWELLE_GRAPH) && (anzBerechnungenGraph1 > 1)) {
        anzBerechnungenGraph1 = anzBerechnungenGraph1/2;
      }
    }
  }

  void GraphikLoeschen() {
  int i;

    plot.clear(true);
    plot.setBackground(Color.white);
    plot.setLayout(null);
    plot.setXRange(0, MAX_BIT_LAENGE_GRAPH);
    plot.setXLabel("Bitlänge Faktoren");
    for (i = 0; i <= MAX_BIT_LAENGE_GRAPH; i = i + 2*MIN_BIT_LAENGE_GRAPH) {
      plot.addXTick(""+i, i);
    }
    if (logYAchse == true) {
      plot.setYLog(true);
      plot.setYRange(MIN_Y_ACHSE_LOG_GRAPH, MAX_Y_ACHSE_LOG_GRAPH);
    }
    else {
      plot.setYRange(0, MAX_Y_ACHSE_GRAPH);
      for (i = 0; i <= MAX_Y_ACHSE_GRAPH; i = i + MAX_Y_ACHSE_GRAPH/5) {
        plot.addYTick(""+i, i);
      }
    }
    plot.setYLabel("Zeit / [ns]");
    plot.setMarksStyle("none");
    plot.addLegend(0, "Alg. 1");
    plot.addLegend(1, "Alg. 2");
    plot.repaint();
  }

  void jButtonStartA_actionPerformed(ActionEvent e) {
    anzStellen = Integer.valueOf(jTextFieldAnzStellen.getText()).intValue();
    faktorA = new BigInteger(jTextFieldFaktorA.getText());
    faktorB = new BigInteger(jTextFieldFaktorB.getText());
    TestBerechnungenA();
  }

  void jButtonStartB_actionPerformed(ActionEvent e) {
    anzStellen = Integer.valueOf(jTextFieldAnzStellen.getText()).intValue();
    faktorA = new BigInteger(jTextFieldFaktorA.getText());
    faktorB = new BigInteger(jTextFieldFaktorB.getText());
    TestBerechnungenB();
  }

  void jButtonStartC_actionPerformed(ActionEvent e) {
    anzStellen = Integer.valueOf(jTextFieldAnzStellen.getText()).intValue();
    faktorA = new BigInteger(jTextFieldFaktorA.getText());
    faktorB = new BigInteger(jTextFieldFaktorB.getText());
    TestBerechnungenC();
  }

  void jButtonLoeschen_actionPerformed(ActionEvent e) {
    anzStellen = Integer.valueOf(jTextFieldAnzStellen.getText()).intValue();
    faktorA = new BigInteger(jTextFieldFaktorA.getText());
    faktorB = new BigInteger(jTextFieldFaktorB.getText());
    GraphikLoeschen();
  }

  void jComboBoxAnzWied_actionPerformed(ActionEvent e) {
    anzStellen = Integer.valueOf(jTextFieldAnzStellen.getText()).intValue();
    faktorA = new BigInteger(jTextFieldFaktorA.getText());
    faktorB = new BigInteger(jTextFieldFaktorB.getText());
    JComboBox cb = (JComboBox)e.getSource();
    String str = (String) cb.getSelectedItem();
    anzWiederholungen = Integer.valueOf(str).intValue();
  }

  void jComboBoxLogLin_actionPerformed(ActionEvent e) {
    anzStellen = Integer.valueOf(jTextFieldAnzStellen.getText()).intValue();
    faktorA = new BigInteger(jTextFieldFaktorA.getText());
    faktorB = new BigInteger(jTextFieldFaktorB.getText());
    JComboBox cb = (JComboBox)e.getSource();
    String str = (String) cb.getSelectedItem();
    if (str == "Log") {
      logYAchse = true;
    }
    else {
      logYAchse = false;
    }
    GraphikLoeschen();
  }

  void jMenuDateiSchliessen_actionPerformed(ActionEvent e) {
    this.dispose();
  }

  void jTextFieldAnzStellen_actionPerformed(ActionEvent e) {
    anzStellen = Integer.valueOf(jTextFieldAnzStellen.getText()).intValue();
    faktorA = new BigInteger(jTextFieldFaktorA.getText());
    faktorB = new BigInteger(jTextFieldFaktorB.getText());
    jTextFieldAnzStellen.selectAll();
  }

  void jTextFieldFaktorA_actionPerformed(ActionEvent e) {
    anzStellen = Integer.valueOf(jTextFieldAnzStellen.getText()).intValue();
    faktorA = new BigInteger(jTextFieldFaktorA.getText());
    faktorB = new BigInteger(jTextFieldFaktorB.getText());
    jTextFieldFaktorA.selectAll();
  }

  void jTextFieldFaktorB_actionPerformed(ActionEvent e) {
    anzStellen = Integer.valueOf(jTextFieldAnzStellen.getText()).intValue();
    faktorA = new BigInteger(jTextFieldFaktorA.getText());
    faktorB = new BigInteger(jTextFieldFaktorB.getText());
    jTextFieldFaktorB.selectAll();
  }
}

class FrameSerieX_jMenuDateiSchliessen_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieX adaptee;

  FrameSerieX_jMenuDateiSchliessen_actionAdapter(FrameSerieX adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuDateiSchliessen_actionPerformed(e);
  }
}

class FrameSerieX_jTextFieldAnzStellen_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieX adaptee;

  FrameSerieX_jTextFieldAnzStellen_actionAdapter(FrameSerieX adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldAnzStellen_actionPerformed(e);
  }
}

class FrameSerieX_jComboBoxAnzWied_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieX adaptee;

  FrameSerieX_jComboBoxAnzWied_actionAdapter(FrameSerieX adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jComboBoxAnzWied_actionPerformed(e);
  }
}

class FrameSerieX_jButtonStartB_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieX adaptee;

  FrameSerieX_jButtonStartB_actionAdapter(FrameSerieX adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartB_actionPerformed(e);
  }
}

class FrameSerieX_jButtonStartC_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieX adaptee;

  FrameSerieX_jButtonStartC_actionAdapter(FrameSerieX adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartC_actionPerformed(e);
  }
}

class FrameSerieX_jButtonLoeschen_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieX adaptee;

  FrameSerieX_jButtonLoeschen_actionAdapter(FrameSerieX adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonLoeschen_actionPerformed(e);
  }
}

class FrameSerieX_jComboBoxLogLin_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieX adaptee;

  FrameSerieX_jComboBoxLogLin_actionAdapter(FrameSerieX adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jComboBoxLogLin_actionPerformed(e);
  }
}

class FrameSerieX_jButtonStartA_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieX adaptee;

  FrameSerieX_jButtonStartA_actionAdapter(FrameSerieX adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartA_actionPerformed(e);
  }
}

class FrameSerieX_jTextFieldFaktorB_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieX adaptee;

  FrameSerieX_jTextFieldFaktorB_actionAdapter(FrameSerieX adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldFaktorB_actionPerformed(e);
  }
}

class FrameSerieX_jTextFieldFaktorA_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieX adaptee;

  FrameSerieX_jTextFieldFaktorA_actionAdapter(FrameSerieX adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldFaktorA_actionPerformed(e);
  }
}
