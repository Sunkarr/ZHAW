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

public class FrameSerieY extends JFrame {
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
  JLabel jLabelDividend = new JLabel();
  JLabel jLabelDivisor = new JLabel();
  JLabel jLabelErgAlg1 = new JLabel();
  JLabel jLabelErgAlg2 = new JLabel();
  JTextField jTextFieldDividend = new JTextField();
  JTextField jTextFieldDivisor = new JTextField();
  JTextPane jTextPaneErgAlg1 = new JTextPane();
  JTextPane jTextPaneErgAlg2 = new JTextPane();
  BigInteger dividend = new BigInteger("0");
  BigInteger divisor = new BigInteger("1");

// Elemente jPanel2
  JButton jButtonStartB = new JButton();
  JComboBox jComboBoxAnzWied;
  JLabel jLabelUntertitelB = new JLabel();
  JLabel jLabelAnzWied = new JLabel();
  JLabel jLabelAnzStellenDividend = new JLabel();
  JLabel jLabelAnzStellenDivisor = new JLabel();
  JLabel jLabelZeitAlg1 = new JLabel();
  JLabel jLabelZeitAlg2 = new JLabel();
  JLabel jLabelResAlg1 = new JLabel();
  JLabel jLabelResAlg2 = new JLabel();
  JTextArea jTextAreaZeitAlg1 = new JTextArea();
  JTextArea jTextAreaZeitAlg2 = new JTextArea();
  JTextField jTextFieldAnzStellenDividend = new JTextField();
  JTextField jTextFieldAnzStellenDivisor = new JTextField();
  JTextPane jTextPaneResAlg1 = new JTextPane();
  JTextPane jTextPaneResAlg2 = new JTextPane();
  String[] anzWiedStrings = {"1", "10", "100", "1000", "10000"};
  int anzStellenDividend;
  int anzStellenDivisor;
  int anzWiederholungen;

// Elemente jPanel3
  JButton jButtonLoeschen = new JButton();
  JButton jButtonStartC = new JButton();
  JComboBox jComboBoxLogLin;
  JComboBox jComboBoxBitVerhZaehlerNenner;
  JLabel jLabelUntertitelC = new JLabel();
  JLabel jLabelLogLin = new JLabel();
  JLabel jLabelBitVerhZaehlerNenner = new JLabel();
  String[] logLinStrings = {"Lin", "Log"};
  String[] bitVerhZaehlerNennerStrings = {"0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8", "0.9", };
  Plot plot = new Plot();
  float bitVerhZaehlerNenner;

  public FrameSerieY() {
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
    this.setTitle("KryptoTrainer Testumgebung zu Serie 3");

// Menu
    jMenuDatei.setText("Datei");
    jMenuDateiSchliessen.setText("Schliessen");
    jMenuDateiSchliessen.addActionListener(new FrameSerieY_jMenuDateiSchliessen_actionAdapter(this));
    jMenuDatei.add(jMenuDateiSchliessen);

    jMenuBar1.add(jMenuDatei);
    this.setJMenuBar(jMenuBar1);

// Panel 1
    jPanel1.setLayout(null);
    jPanel1.setBackground(Color.white);
    jButtonStartA.setText("Start");
    jButtonStartA.setBounds(new Rectangle(496, 68, 62, 25));
    jButtonStartA.addActionListener(new FrameSerieY_jButtonStartA_actionAdapter(this));
    jLabelTitel.setFont(new java.awt.Font("Times New Roman", 1, 19));
    jLabelTitel.setHorizontalAlignment(SwingConstants.LEFT);
    jLabelTitel.setHorizontalTextPosition(SwingConstants.LEADING);
    jLabelTitel.setText("Testumgebung zu Serie 3 (Division)");
    jLabelTitel.setBounds(new Rectangle(1, 1, 564, 23));
    jLabelUntertitelA.setText("a) Ergebnisse im Vergleich");
    jLabelUntertitelA.setBounds(new Rectangle(9, 29, 255, 17));
    jLabelUntertitelA.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelDividend.setText("Dividend");
    jLabelDividend.setBounds(new Rectangle(385, 51, 133, 15));
    jLabelDivisor.setText("Divisor");
    jLabelDivisor.setBounds(new Rectangle(385, 75, 133, 15));
    jLabelErgAlg1.setText("Ergebnis Alg. 1 (myDivide)");
    jLabelErgAlg1.setBounds(new Rectangle(9, 94, 291, 15));
    jLabelErgAlg2.setText("Ergebnis Alg. 2 (divide)");
    jLabelErgAlg2.setBounds(new Rectangle(9, 171, 373, 15));
    jTextFieldDividend.setText("" + dividend);
    jTextFieldDividend.setBounds(new Rectangle(9, 48, 373, 21));
    jTextFieldDividend.addActionListener(new FrameSerieY_jTextFieldDividend_actionAdapter(this));
    jTextFieldDividend.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldDividend.setSelectionEnd(11);
    jTextFieldDivisor.setText("" + divisor);
    jTextFieldDivisor.setBounds(new Rectangle(9, 72, 373, 21));
    jTextFieldDivisor.addActionListener(new FrameSerieY_jTextFieldDivisor_actionAdapter(this));
    jTextFieldDivisor.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldDivisor.setSelectionEnd(11);
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
    jPanel1.add(jLabelDividend, null);
    jPanel1.add(jLabelDivisor, null);
    jPanel1.add(jLabelErgAlg1, null);
    jPanel1.add(jLabelErgAlg2, null);
    jPanel1.add(jTextFieldDividend, null);
    jPanel1.add(jTextFieldDivisor, null);
    jPanel1.add(jTextPaneErgAlg1, null);
    jPanel1.add(jTextPaneErgAlg2, null);

// Panel 2
    anzStellenDividend = 32;
    anzStellenDivisor = 16;
    anzWiederholungen = Integer.valueOf(anzWiedStrings[0]).intValue();
    jPanel2.setLayout(null);
    jPanel2.setBackground(Color.white);
    jButtonStartB.setBounds(new Rectangle(496, 71, 62, 25));
    jButtonStartB.setText("Start");
    jButtonStartB.addActionListener(new FrameSerieY_jButtonStartB_actionAdapter(this));
    jComboBoxAnzWied = new JComboBox(anzWiedStrings);
    jComboBoxAnzWied.setBounds(new Rectangle(9, 75, 57, 21));
    jComboBoxAnzWied.addActionListener(new FrameSerieY_jComboBoxAnzWied_actionAdapter(this));
    jLabelUntertitelB.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelUntertitelB.setText("b) Ergebnis und Laufzeit im Vergleich");
    jLabelUntertitelB.setBounds(new Rectangle(9, 3, 255, 17));
    jLabelAnzWied.setText("Anzahl zufälliger Berechnungen");
    jLabelAnzWied.setBounds(new Rectangle(70, 78, 161, 15));
    jLabelAnzStellenDividend.setText("Bitlänge der Zufallszahlen Dividend");
    jLabelAnzStellenDividend.setBounds(new Rectangle(70, 26, 216, 15));
    jLabelAnzStellenDivisor.setText("Bitlänge der Zufallszahlen Divisor");
    jLabelAnzStellenDivisor.setBounds(new Rectangle(70, 52, 161, 15));
    jLabelZeitAlg1.setText("Rechenzeit Alg. 1 (myDivide)");
    jLabelZeitAlg1.setBounds(new Rectangle(389, 139, 158, 15));
    jLabelZeitAlg2.setText("Rechenzeit Alg. 2 (divide)");
    jLabelZeitAlg2.setBounds(new Rectangle(389, 204, 145, 15));
    jLabelResAlg1.setText("Ergebnis der letzten Rechnung Alg. 1 (myDivide)");
    jLabelResAlg1.setBounds(new Rectangle(10, 108, 305, 15));
    jLabelResAlg2.setText("Ergebnis der letzten Rechnung Alg. 2 (divide)");
    jLabelResAlg2.setBounds(new Rectangle(9, 173, 296, 15));
    jTextAreaZeitAlg1.setBackground(Color.lightGray);
    jTextAreaZeitAlg1.setEditable(false);
    jTextAreaZeitAlg1.setText("");
    jTextAreaZeitAlg1.setBounds(new Rectangle(389, 155, 131, 17));
    jTextAreaZeitAlg2.setBackground(Color.lightGray);
    jTextAreaZeitAlg2.setEditable(false);
    jTextAreaZeitAlg2.setText("");
    jTextAreaZeitAlg2.setBounds(new Rectangle(389, 220, 131, 17));
    jTextFieldAnzStellenDividend.setSelectionEnd(11);
    jTextFieldAnzStellenDividend.setText("" + anzStellenDividend);
    jTextFieldAnzStellenDividend.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldAnzStellenDividend.setBounds(new Rectangle(9, 23, 57, 21));
    jTextFieldAnzStellenDividend.addActionListener(new FrameSerieY_jTextFieldAnzStellenDividend_actionAdapter(this));
    jTextFieldAnzStellenDivisor.setSelectionEnd(11);
    jTextFieldAnzStellenDivisor.setText("" + anzStellenDivisor);
    jTextFieldAnzStellenDivisor.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldAnzStellenDivisor.setBounds(new Rectangle(9, 49, 57, 21));
    jTextFieldAnzStellenDivisor.addActionListener(new FrameSerieY_jTextFieldAnzStellenDivisor_actionAdapter(this));
    jTextPaneResAlg1.setBackground(Color.lightGray);
    jTextPaneResAlg1.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneResAlg1.setEditable(false);
    jTextPaneResAlg1.setText("");
    jTextPaneResAlg1.setBounds(new Rectangle(10, 124, 373, 48));
    jTextPaneResAlg2.setBackground(Color.lightGray);
    jTextPaneResAlg2.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneResAlg2.setEditable(false);
    jTextPaneResAlg2.setText("");
    jTextPaneResAlg2.setBounds(new Rectangle(9, 189, 373, 48));

    jPanel2.add(jButtonStartB, null);
    jPanel2.add(jComboBoxAnzWied, null);
    jPanel2.add(jLabelUntertitelB, null);
    jPanel2.add(jLabelAnzStellenDividend, null);
    jPanel2.add(jLabelAnzStellenDivisor, null);
    jPanel2.add(jLabelResAlg1, null);
    jPanel2.add(jLabelResAlg2, null);
    jPanel2.add(jLabelZeitAlg1, null);
    jPanel2.add(jLabelZeitAlg2, null);
    jPanel2.add(jLabelAnzWied, null);
    jPanel2.add(jTextAreaZeitAlg1, null);
    jPanel2.add(jTextAreaZeitAlg2, null);
    jPanel2.add(jTextFieldAnzStellenDividend, null);
    jPanel2.add(jTextFieldAnzStellenDivisor, null);
    jPanel2.add(jTextPaneResAlg1, null);
    jPanel2.add(jTextPaneResAlg2, null);

// Panel 3
    bitVerhZaehlerNenner = Float.valueOf(bitVerhZaehlerNennerStrings[0]).floatValue();
    jPanel3.setLayout(null);
    jPanel3.setBackground(Color.white);
    jPanel3.setOpaque(true);
    jButtonStartC.setText("Start");
    jButtonStartC.setBounds(new Rectangle(496, 20, 62, 25));
    jButtonStartC.addActionListener(new FrameSerieY_jButtonStartC_actionAdapter(this));
    jButtonLoeschen.setText("Löschen");
    jButtonLoeschen.setBounds(new Rectangle(400, 20, 77, 25));
    jButtonLoeschen.addActionListener(new FrameSerieY_jButtonLoeschen_actionAdapter(this));
    jComboBoxLogLin = new JComboBox(logLinStrings);
    jComboBoxLogLin.setBounds(new Rectangle(8, 24, 46, 21));
    jComboBoxLogLin.addActionListener(new FrameSerieY_jComboBoxLogLin_actionAdapter(this));
    jComboBoxBitVerhZaehlerNenner = new JComboBox(bitVerhZaehlerNennerStrings);
    jComboBoxBitVerhZaehlerNenner.setBounds(new Rectangle(8, 4, 46, 21));
    jComboBoxBitVerhZaehlerNenner.addActionListener(new FrameSerieY_jComboBoxBitVerhZaehlerNenner_actionAdapter(this));
    jLabelUntertitelC.setText("c) Graphische Auswertung der Laufzeit");
    jLabelUntertitelC.setBounds(new Rectangle(8, 0, 270, 17));
    jLabelUntertitelC.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelLogLin.setText("Skalierung der y-Achse");
    jLabelLogLin.setBounds(new Rectangle(58, 27, 124, 15));
    jLabelBitVerhZaehlerNenner.setText("Bitlängenverhältnis Dividend/Divisor");
    jLabelBitVerhZaehlerNenner.setBounds(new Rectangle(59, 7, 240, 15));
    plot.setBounds(new Rectangle(0, 45, 598, 207));

    jPanel3.add(jButtonLoeschen, null);
    jPanel3.add(jButtonStartC, null);
    jPanel3.add(jComboBoxLogLin, null);
    plot.add(jComboBoxBitVerhZaehlerNenner, null);
    jPanel3.add(jLabelUntertitelC, null);
    jPanel3.add(jLabelLogLin, null);
    plot.add(jLabelBitVerhZaehlerNenner, null);
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
    plot.add(jLabelBitVerhZaehlerNenner, null);
  }

// Testberechnungen Teil (a)
  void TestBerechnungenA() {
    BigInteger quot;

    // Berechnungen mit myDivide()
    quot = dividend;
    quot = quot.myDivide(divisor);
    jTextPaneErgAlg1.setText(quot.toString());

    // Berechnungen mit divide()
    quot = dividend;
    quot = quot.divide(divisor);
    jTextPaneErgAlg2.setText(quot.toString());
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
      n = new BigInteger(anzStellenDividend, rnd);
      numArrayN[i] = n;
      m = new BigInteger(anzStellenDivisor, rnd);
      if (m.compareTo(BigInteger.ZERO) == 0) {
        m = BigInteger.ONE;
      }
      numArrayM[i] = m;
    }

    // Berechnungen mit myDivide()
    zeitStempelAnf = new Time(System.currentTimeMillis());
    for (i = 0; i < anzWiederholungen; i++) {
      n = numArrayN[i];
      m = numArrayM[i];
      n = n.myDivide(m);
    }
    zeitStempelEnd = new Time(System.currentTimeMillis());
    jTextAreaZeitAlg1.setText("" + (zeitStempelEnd.getTime()-zeitStempelAnf.getTime()) + " ms");
    jTextPaneResAlg1.setText(n.toString());

    // Berechnungen mit divide()
    zeitStempelAnf = new Time(System.currentTimeMillis());
    for (i = 0; i < anzWiederholungen; i++) {
      n = numArrayN[i];
      m = numArrayM[i];
      n = n.divide(m);
    }
    zeitStempelEnd = new Time(System.currentTimeMillis());
    jTextAreaZeitAlg2.setText("" + (zeitStempelEnd.getTime()-zeitStempelAnf.getTime()) + " ms");
    jTextPaneResAlg2.setText(n.toString());
  }

// Testberechnungen Teil (c)
  boolean logYAchse = false;
  final int ZEIT_SCHWELLE_GRAPH = 500;        // Zeit in ms
  final int MAX_BERECHNUNGEN_GRAPH = 16384;
  final int MIN_BIT_LAENGE_GRAPH = 256;
  final int MAX_BIT_LAENGE_GRAPH = 4096;
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
        m = new BigInteger((int)(i*bitVerhZaehlerNenner), rnd);
        if (m.compareTo(BigInteger.ZERO) == 0) {
          m = BigInteger.ONE;
        }
        numArrayM[k] = m;
      }

      // Berechnungen mit myDivide()
      zeitStempelAnf = new Time(System.currentTimeMillis());
      for (k = 0; k < anzBerechnungenGraph0; k++) {
        n = numArrayN[k];
        m = numArrayM[k];
        n = n.myDivide(m);
      }
      zeitStempelEnd = new Time(System.currentTimeMillis());
      zeit = zeitStempelEnd.getTime()-zeitStempelAnf.getTime();
      plot.addPoint(0, i, 1000*zeit/anzBerechnungenGraph0, !ersterPunktGraph0);
      ersterPunktGraph0 = false;
      if ((zeit >= ZEIT_SCHWELLE_GRAPH) && (anzBerechnungenGraph0 > 1)) {
        anzBerechnungenGraph0 = anzBerechnungenGraph0/2;
      }

      // Berechnungen mit divide()
      zeitStempelAnf = new Time(System.currentTimeMillis());
      for (k = 0; k < anzBerechnungenGraph1; k++) {
        n = numArrayN[k];
        m = numArrayM[k];
        n = n.divide(m);
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
    plot.setXLabel("Bitlänge Dividend");
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
    anzStellenDividend = Integer.valueOf(jTextFieldAnzStellenDividend.getText()).intValue();
    anzStellenDivisor = Integer.valueOf(jTextFieldAnzStellenDivisor.getText()).intValue();
    dividend = new BigInteger(jTextFieldDividend.getText());
    divisor = new BigInteger(jTextFieldDivisor.getText());
    TestBerechnungenA();
  }

  void jButtonStartB_actionPerformed(ActionEvent e) {
    anzStellenDividend = Integer.valueOf(jTextFieldAnzStellenDividend.getText()).intValue();
    anzStellenDivisor = Integer.valueOf(jTextFieldAnzStellenDivisor.getText()).intValue();
    dividend = new BigInteger(jTextFieldDividend.getText());
    divisor = new BigInteger(jTextFieldDivisor.getText());
    TestBerechnungenB();
  }

  void jButtonStartC_actionPerformed(ActionEvent e) {
    anzStellenDividend = Integer.valueOf(jTextFieldAnzStellenDividend.getText()).intValue();
    anzStellenDivisor = Integer.valueOf(jTextFieldAnzStellenDivisor.getText()).intValue();
    dividend = new BigInteger(jTextFieldDividend.getText());
    divisor = new BigInteger(jTextFieldDivisor.getText());
    TestBerechnungenC();
  }

  void jButtonLoeschen_actionPerformed(ActionEvent e) {
    anzStellenDividend = Integer.valueOf(jTextFieldAnzStellenDividend.getText()).intValue();
    anzStellenDivisor = Integer.valueOf(jTextFieldAnzStellenDivisor.getText()).intValue();
    dividend = new BigInteger(jTextFieldDividend.getText());
    divisor = new BigInteger(jTextFieldDivisor.getText());
    GraphikLoeschen();
  }

  void jComboBoxAnzWied_actionPerformed(ActionEvent e) {
    anzStellenDividend = Integer.valueOf(jTextFieldAnzStellenDividend.getText()).intValue();
    anzStellenDivisor = Integer.valueOf(jTextFieldAnzStellenDivisor.getText()).intValue();
    dividend = new BigInteger(jTextFieldDividend.getText());
    divisor = new BigInteger(jTextFieldDivisor.getText());
    JComboBox cb = (JComboBox)e.getSource();
    String str = (String) cb.getSelectedItem();
    anzWiederholungen = Integer.valueOf(str).intValue();
  }

  void jComboBoxLogLin_actionPerformed(ActionEvent e) {
    anzStellenDividend = Integer.valueOf(jTextFieldAnzStellenDividend.getText()).intValue();
    anzStellenDivisor = Integer.valueOf(jTextFieldAnzStellenDivisor.getText()).intValue();
    dividend = new BigInteger(jTextFieldDividend.getText());
    divisor = new BigInteger(jTextFieldDivisor.getText());
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

  void jComboBoxBitVerhZaehlerNenner_actionPerformed(ActionEvent e) {
    anzStellenDividend = Integer.valueOf(jTextFieldAnzStellenDividend.getText()).intValue();
    anzStellenDivisor = Integer.valueOf(jTextFieldAnzStellenDivisor.getText()).intValue();
    dividend = new BigInteger(jTextFieldDividend.getText());
    divisor = new BigInteger(jTextFieldDivisor.getText());
    JComboBox cb = (JComboBox)e.getSource();
    String str = (String) cb.getSelectedItem();
    bitVerhZaehlerNenner = Float.valueOf(str).floatValue();
  }

  void jMenuDateiSchliessen_actionPerformed(ActionEvent e) {
    this.dispose();
  }

  void jTextFieldAnzStellenDividend_actionPerformed(ActionEvent e) {
    anzStellenDividend = Integer.valueOf(jTextFieldAnzStellenDividend.getText()).intValue();
    anzStellenDivisor = Integer.valueOf(jTextFieldAnzStellenDivisor.getText()).intValue();
    dividend = new BigInteger(jTextFieldDividend.getText());
    divisor = new BigInteger(jTextFieldDivisor.getText());
    jTextFieldAnzStellenDividend.selectAll();
  }

  void jTextFieldAnzStellenDivisor_actionPerformed(ActionEvent e) {
    anzStellenDividend = Integer.valueOf(jTextFieldAnzStellenDividend.getText()).intValue();
    anzStellenDivisor = Integer.valueOf(jTextFieldAnzStellenDivisor.getText()).intValue();
    dividend = new BigInteger(jTextFieldDividend.getText());
    divisor = new BigInteger(jTextFieldDivisor.getText());
    jTextFieldAnzStellenDivisor.selectAll();
  }

  void jTextFieldDividend_actionPerformed(ActionEvent e) {
    anzStellenDividend = Integer.valueOf(jTextFieldAnzStellenDividend.getText()).intValue();
    anzStellenDivisor = Integer.valueOf(jTextFieldAnzStellenDivisor.getText()).intValue();
    dividend = new BigInteger(jTextFieldDividend.getText());
    divisor = new BigInteger(jTextFieldDivisor.getText());
    jTextFieldDividend.selectAll();
  }

  void jTextFieldDivisor_actionPerformed(ActionEvent e) {
    anzStellenDividend = Integer.valueOf(jTextFieldAnzStellenDividend.getText()).intValue();
    anzStellenDivisor = Integer.valueOf(jTextFieldAnzStellenDivisor.getText()).intValue();
    dividend = new BigInteger(jTextFieldDividend.getText());
    divisor = new BigInteger(jTextFieldDivisor.getText());
    jTextFieldDivisor.selectAll();
  }
}

class FrameSerieY_jMenuDateiSchliessen_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieY adaptee;

  FrameSerieY_jMenuDateiSchliessen_actionAdapter(FrameSerieY adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuDateiSchliessen_actionPerformed(e);
  }
}

class FrameSerieY_jTextFieldAnzStellenDividend_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieY adaptee;

  FrameSerieY_jTextFieldAnzStellenDividend_actionAdapter(FrameSerieY adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldAnzStellenDividend_actionPerformed(e);
  }
}

class FrameSerieY_jComboBoxAnzWied_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieY adaptee;

  FrameSerieY_jComboBoxAnzWied_actionAdapter(FrameSerieY adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jComboBoxAnzWied_actionPerformed(e);
  }
}

class FrameSerieY_jButtonStartB_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieY adaptee;

  FrameSerieY_jButtonStartB_actionAdapter(FrameSerieY adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartB_actionPerformed(e);
  }
}

class FrameSerieY_jButtonStartC_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieY adaptee;

  FrameSerieY_jButtonStartC_actionAdapter(FrameSerieY adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartC_actionPerformed(e);
  }
}

class FrameSerieY_jButtonLoeschen_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieY adaptee;

  FrameSerieY_jButtonLoeschen_actionAdapter(FrameSerieY adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonLoeschen_actionPerformed(e);
  }
}

class FrameSerieY_jComboBoxLogLin_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieY adaptee;

  FrameSerieY_jComboBoxLogLin_actionAdapter(FrameSerieY adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jComboBoxLogLin_actionPerformed(e);
  }
}

class FrameSerieY_jComboBoxBitVerhZaehlerNenner_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieY adaptee;

  FrameSerieY_jComboBoxBitVerhZaehlerNenner_actionAdapter(FrameSerieY adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jComboBoxBitVerhZaehlerNenner_actionPerformed(e);
  }
}

class FrameSerieY_jButtonStartA_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieY adaptee;

  FrameSerieY_jButtonStartA_actionAdapter(FrameSerieY adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartA_actionPerformed(e);
  }
}

class FrameSerieY_jTextFieldDivisor_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieY adaptee;

  FrameSerieY_jTextFieldDivisor_actionAdapter(FrameSerieY adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldDivisor_actionPerformed(e);
  }
}

class FrameSerieY_jTextFieldDividend_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieY adaptee;

  FrameSerieY_jTextFieldDividend_actionAdapter(FrameSerieY adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldDividend_actionPerformed(e);
  }
}

class FrameSerieY_jTextFieldAnzStellenDivisor_actionAdapter implements java.awt.event.ActionListener {
  FrameSerieY adaptee;

  FrameSerieY_jTextFieldAnzStellenDivisor_actionAdapter(FrameSerieY adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldAnzStellenDivisor_actionPerformed(e);
  }
}
